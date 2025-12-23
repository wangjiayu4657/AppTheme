//
//  ThemeColor.h
//  AppTheme
//
//  Created by 王家玉 on 2025/12/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ThemeColor : NSProxy<NSCopying>

@property(nonatomic, readonly) NSString *colorName;
@property(nonatomic, readonly) NSString *moduleName;

+ (instancetype)colorWithMoudleName:(NSString *)moduleName colorName:(NSString *)colorName;

@end

NS_ASSUME_NONNULL_END
