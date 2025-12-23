//
//  BundleManager.h
//  AppTheme
//
//  Created by 王家玉 on 2025/12/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BundleManager : NSObject

///获取颜色
+(UIColor *)colorForName:(NSString *)name inBundle:(NSString *)bundleName;
///获取图片
+(UIImage *)imageForName:(NSString *)name inBundle:(NSString *)bundleName cacheable:(BOOL)cacheable;

+(NSString *)overrideSuffix;
+(void)setOverrideSuffix:(NSString *)suffix;
+(void)setDebug:(BOOL)debuggable;
+(void)clearCache;

@end

NS_ASSUME_NONNULL_END
