//
//  BundleManager.m
//  AppTheme
//
//  Created by 王家玉 on 2025/12/20.
//

#import "BundleManager.h"

static inline id makeResourceKey(NSString * value1, NSString * value2, NSString * value3, NSString * value4) {
	NSUInteger result = 1;
	NSUInteger prime = 31;
	
	result = prime * result + value1.hash;
	result = prime * result + value2.hash;
	result = prime * result + value3.hash;
	result = prime * result + value4.hash;
	
	return @(result);
}

static inline NSString * makeResourcePath(NSString * bundleName, NSString * subPath, NSString * resourcePath) {
	NSString * path = [NSBundle.mainBundle.resourcePath stringByAppendingPathComponent:bundleName];
	
	if(subPath && subPath.length > 0) {
		path = [path stringByAppendingPathComponent:subPath];
	}
	
	path = [path stringByAppendingPathComponent:resourcePath];

	if(![[NSFileManager defaultManager] isReadableFileAtPath:path]) {
		path = nil;
	}

	return path;
}

static inline NSString * makeBundleName(NSString * bundleName, NSString * overrideSuffix) {
	if(overrideSuffix && overrideSuffix.length > 0) {
		if([bundleName hasSuffix:@".bundle"]) {
			// 去掉.bundle
			bundleName = [bundleName substringToIndex:bundleName.length - 7];
			bundleName = [NSString stringWithFormat:@"%@.%@.bundle", bundleName, overrideSuffix];
		} else {
			bundleName = [NSString stringWithFormat:@"%@.%@.bundle", bundleName, overrideSuffix];
		}
	} else if(![bundleName hasSuffix:@".bundle"]) {
		bundleName = [NSString stringWithFormat:@"%@.bundle", bundleName];
	}
	
	return bundleName;
}


static inline int up_isascii(int _c) {
	return ((_c & ~0x7F) == 0);
}

// 简易计算对象占用的内存大小, 效率优先
static NSUInteger objectSize(id object) {
	if(object) {
		if([object isKindOfClass:NSString.class]) {
			NSString * str = (NSString *)object;
			
			if(str.length > 0) {
				// 取首、尾、中三个字符, 判断是否为ascii字符
				// 如果全是, 就用字符串长度
				// 如果不全是, 就用字符串长度*2(简易计算, 不考虑变长的编码方式)
				unichar c1 = [str characterAtIndex:0];
				unichar c2 = [str characterAtIndex:str.length / 2];
				unichar c3 = [str characterAtIndex:str.length - 1];
				
				if(up_isascii(c1) && up_isascii(c2) && up_isascii(c3)) {
					return str.length;
				} else {
					return str.length * 2;
				}
			}
		} else if ([object isKindOfClass:UIColor.class]) {
			return 64; // 通过malloc_size获取
		} else if ([object isKindOfClass:UIImage.class]) {
			CGImageRef ref = [(UIImage *)object CGImage];
			return CGImageGetHeight(ref) * CGImageGetBytesPerRow(ref);
		} else if ([object isKindOfClass:NSData.class]) {
			return [(NSData *)object length];
		} else if ([object isKindOfClass:NSDictionary.class]) {
			NSDictionary * dict = (NSDictionary *)object;
			
			if(dict.count > 0) {
				return objectSize(dict.allKeys) + objectSize(dict.allValues);
			}
		} else if ([object isKindOfClass:NSArray.class]) {
			NSArray * array = (NSArray *)object;
			
			if(array.count > 0) {
				// 取首、尾、中三个对象, 取平均长度*count
				id o1 = [array objectAtIndex:0];
				id o2 = [array objectAtIndex:array.count / 2];
				id o3 = [array objectAtIndex:array.count - 1];
				
				return (objectSize(o1) + objectSize(o2) + objectSize(o3)) / 3 * array.count;
			}
		}
	}
	
	return 64;
}

static NSException * makeException(NSString * format, ...) NS_NO_TAIL_CALL {
	va_list args;
	va_start(args, format);
	
	NSString * msg = [[NSString alloc] initWithFormat:format arguments:args];
	
	va_end(args);
	
	return [NSException exceptionWithName:@"UPBundleResourceException"
																 reason:msg
															 userInfo:nil];
}


static BOOL _debuggable = NO;

@interface BundleManager()<NSCacheDelegate> {
	NSCache *_cache;
	NSCache *_cache2;
	NSString *_l10nPath;
	NSString *_overrideSuffix;
}

@end


@implementation BundleManager

+ (instancetype)manager {
	static BundleManager *bundleNanager = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		bundleNanager = [[BundleManager alloc] init];
	});
	return bundleNanager;
}

- (instancetype)init {
	self = [super init];
	if (self) {
		_cache = [[NSCache alloc] init];
		_cache.name = @"BundlerManagerCache";
		_cache.totalCostLimit = NSProcessInfo.processInfo.physicalMemory / 2 / 3;
		_cache.delegate = self;
		
		_cache2 = [[NSCache alloc] init];
		_cache2.name = @"BundlerManagerCache2";
		_cache2.delegate = self;
		
		_l10nPath = [NSString stringWithFormat:@"%@.lproj", NSBundle.mainBundle.preferredLocalizations.firstObject];
		NSLog(@"_l10nPath == %@",_l10nPath);
		
		[[NSNotificationCenter defaultCenter] addObserver:self
																						 selector:@selector(onNotification:)
																								 name:UIApplicationDidReceiveMemoryWarningNotification
																							 object:nil];
	}
	return self;
}


#pragma mark - public

///获取颜色
+ (UIColor *)colorForName:(NSString *)name inBundle:(NSString *)bundleName {
	UIColor *color = [[BundleManager manager] colorForName:name inBundle:bundleName];
	
	if(_debuggable && color == nil) {
		@throw makeException(@"Can not found color for %@ in %@", name, bundleName);
	}
	
	return color;
}

///获取图片
+ (UIImage *)imageForName:(NSString *)name inBundle:(NSString *)bundleName cacheable:(BOOL)cacheable {
	return nil;
}

+ (NSString *)overrideSuffix {
	return [[BundleManager manager] overrideSuffix];
}

+ (void)setOverrideSuffix:(NSString *)suffix {
	[[BundleManager manager] setOverrideSuffix:suffix];
}

+ (void)clearCache {
	[[BundleManager manager] clearCache];
}

+ (void)setDebug:(BOOL)debuggable {
	_debuggable = debuggable;
}


#pragma mark - NSCacheDelegate

- (void)cache:(NSCache *)cache willEvictObject:(id)obj {
	NSLog(@"[BundleManager] Will evict cache");
}


#pragma mark - events

- (void)onNotification:(NSNotification *)notification {
	if([notification.name isEqualToString:UIApplicationDidReceiveMemoryWarningNotification]) {
		[self clearCache];
	}
}


#pragma mark - private

- (UIColor *)colorForName:(NSString *)name inBundle:(NSString *)bundleName {
	UIColor *color = nil;
	NSString *overrideSuffix = _overrideSuffix;
	id key = makeResourceKey(bundleName, name, @"color", overrideSuffix);
	
	color = [_cache objectForKey:key];
	if(color && ![color isKindOfClass:[UIColor class]]) {
		NSLog(@"[BundleManager] Need UIColor for %@ in %@, but got %@", name, bundleName, NSStringFromClass(color.class));
		color = nil;
	}
	
	NSString *bundleName1 = makeBundleName(bundleName, overrideSuffix);
	NSLog(@"bundleName1 == %@",bundleName1);
	
	if(!color) {
		NSString *value = nil;
		if(overrideSuffix.length > 0) {
			value = [self stringForName:name inBundle:makeBundleName(bundleName, overrideSuffix) inFile:@"colors.strings"];
			
			if(!value) {
				value = [self stringForName:name inBundle:makeBundleName(bundleName, nil) inFile:@"colors.strings"];
			}
			
			if(value) {
				//颜色二级缓存, 同样的颜色值不重复生成 UIColor 对象
				id key2 = makeResourceKey(value, @"color", nil, nil);
				color = [_cache2 objectForKey:key2];
				
				if(color && ![color isKindOfClass:[UIColor class]]) {
					NSLog(@"[BundleManager] Need UIColor for %@, but got %@", value, NSStringFromClass(color.class));
					color = nil;
				}
				
				if(!color) {
					color = [UIColor colorWithHexString:value];
					if(color) {
						[_cache2 setObject:color forKey:key2];;
					}
				}
				
				if(color) {
					[_cache setObject:color forKey:key cost:objectSize(color)];
				}
			}
		}
	}
	
	return color;
}

- (NSString *)stringForName:(NSString *)name inBundle:(NSString *)bundleName inFile:(NSString *)file {
	NSString *string = nil;
	NSDictionary *l10nDict = [self stringDictionaryFromFile:file inBundle:bundleName subPath:_l10nPath];
	if(l10nDict) {
		string = [l10nDict objectForKey:name];
	}
	
	if(!string) {
		NSDictionary *defaultDict = [self stringDictionaryFromFile:file inBundle:bundleName subPath:nil];
		if(defaultDict) {
			string = [defaultDict objectForKey:name];
		}
	}
	
	if(string && ![string isKindOfClass:[NSString class]]) {
		NSLog(@"[BundleManager] Need NSString for %@, but got %@", name, NSStringFromClass(string.class));
		string = nil;
	}
	
	return string;
}

- (NSDictionary *)stringDictionaryFromFile:(NSString *)file inBundle:(NSString *)bundleName subPath:(NSString *)subPath {
	NSDictionary *dict = nil;
	
	id key = makeResourceKey(bundleName, subPath, file, nil);
	dict = [_cache2 objectForKey:key];
	if(dict && ![dict isKindOfClass:[NSDictionary class]]) {
		NSLog(@"[BundleManager] Need NSDictionary for %@/%@/%@, but got %@",bundleName, subPath, file, NSStringFromClass(dict.class));
		dict = nil;
	}
	
	if(!dict) {
		NSString *path = makeResourcePath(bundleName, subPath, file);
		if(path && path.length > 0) {
			dict = [NSDictionary dictionaryWithContentsOfFile:path];
		}
		
		if(dict) {
			[_cache2 setObject:dict forKey:key];
		}
	}
	
	return dict;
}


- (NSString *)overrideSuffix {
	return _overrideSuffix;
}

-(void)setOverrideSuffix:(NSString *)suffix {
	if(suffix && suffix.length > 0) {
		_overrideSuffix = [suffix copy];
	} else {
		_overrideSuffix = nil;
	}
	
	[self clearCache];
}

- (void)clearCache {
	[_cache removeAllObjects];
	[_cache2 removeAllObjects];
}

@end
