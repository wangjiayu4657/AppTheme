//
//  BundleResourceMacro.h
//  AppTheme
//
//  Created by 王家玉 on 2025/12/20.
//

#ifndef BundleResourceMacro_h
#define BundleResourceMacro_h


#pragma mark - Module name macro

#define UPR_BUNDLE_SUFFIX "Resource"

#define _UPR_STRING(x) #x
#define UPR_STRING(x) _UPR_STRING(x)

#define UPR_BUNDLE(name) name UPR_BUNDLE_SUFFIX

#ifdef UPR_MODULE
#define UPR_SELF_BUNDLE @UPR_STRING(UPR_MODULE)UPR_BUNDLE_SUFFIX
#else
#define UPR_SELF_BUNDLE nil
#endif


#pragma mark - Helper macro (string)



#endif /* BundleResourceMacro_h */
