//
//  ThemeColor.m
//  AppTheme
//
//  Created by 王家玉 on 2025/12/22.
//

#import "ThemeColor.h"
#import "BundleManager.h"


@interface ThemeColor()

@property(nonatomic, copy) NSString *resourceSuffix;
@property(nonatomic, strong) UIColor *resolvedColor;
@property(nonatomic, assign) unsigned alpha;

@end


@implementation ThemeColor {
	NSString * _colorName;
	NSString * _moduleName;
}

- (instancetype)initWithMoudleName:(NSString *)moduleName colorName:(NSString *)colorName {
	_colorName = colorName;
	_moduleName = moduleName;
	
	_resourceSuffix = nil;
	_alpha = 255;
	
	return self;
}

+ (instancetype)colorWithMoudleName:(NSString *)moduleName colorName:(NSString *)colorName {
	return [[ThemeColor alloc] initWithMoudleName:moduleName colorName:colorName];
}

- (NSString *)colorName {
	return _colorName;
}

- (NSString *)moduleName {
	return _moduleName;
}

- (UIColor *)resolvedColor {
	NSString *suffix = [BundleManager overrideSuffix];
	NSLog(@"suffix == %@",suffix);
	
	if(!_resourceSuffix && ![suffix isEqualToString:_resourceSuffix]) {
		_resourceSuffix = [suffix copy];
		
		UIColor *color = [BundleManager colorForName:_colorName inBundle:_moduleName];
		color = color ?: UIColor.clearColor;  //没有获取到颜色给个默认值
		
		if(_alpha != 255) {
			color = [color colorWithAlphaComponent:_alpha / 255.0];
		}
		
		_resolvedColor = color;
	}
	
	return _resolvedColor;
}


#pragma mark - NSProxy

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
	return [self.resolvedColor methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
	[invocation invokeWithTarget:self.resolvedColor];
}


#pragma mark - NSObject

- (BOOL)isKindOfClass:(Class)aClass {
	if(aClass == ThemeColor.class) {
		return YES;
	}
	
	return [self.resolvedColor isKindOfClass:aClass];
}


#pragma mark - NSCopying

- (id)copy {
	return [self copyWithZone:nil];
}

- (id)copyWithZone:(NSZone *)zone {
	ThemeColor *themeColor = [ThemeColor colorWithMoudleName:_moduleName colorName:_colorName];
	themeColor.alpha = _alpha;
	return themeColor;
}


#pragma mark - UIColor

- (UIColor *)colorWithAlphaComponent:(CGFloat)alpha {
	ThemeColor *themeColor = [self copy];
	themeColor.alpha = 255.0 * _alpha;
	return (UIColor *)themeColor;
}

@end
