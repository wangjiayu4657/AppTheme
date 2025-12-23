//
//  ThemeMacro.h
//  AppTheme
//
//  Created by 王家玉 on 2025/12/20.
//

#ifndef ThemeMacro_h
#define ThemeMacro_h


#import "ThemeColor.h"
#import "BundleResourceMacro.h"


#pragma mark - color

#define UPTColorInModule(name, module) ((UIColor *)[ThemeColor colorWithMoudleName:(UPR_BUNDLE(module)) colorName:(name)])



#endif /* ThemeMacro_h */
