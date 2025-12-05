//
//  ThemeCommon.h
//  FontScale
//
//  Created by 王家玉 on 2025/11/26.
//

#ifndef ThemeCommon_h
#define ThemeCommon_h

#import <objc/runtime.h>

static void theme_swizzleSelector(Class cls, SEL originalSelector, SEL swizzledSelector) {
  Method originalMethod = class_getInstanceMethod(cls, originalSelector);
  Method swizzledMethod = class_getInstanceMethod(cls, swizzledSelector);
  if (class_addMethod(cls, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
    class_replaceMethod(cls, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
  } else {
    method_exchangeImplementations(originalMethod, swizzledMethod);
  }
}

static void theme_exchangeSelector(Class cls, SEL originalSelector, SEL swizzledSelector) {
	Method originalMethod = class_getClassMethod(cls, originalSelector);
	Method swizzledMethod = class_getClassMethod(cls, swizzledSelector);
	method_exchangeImplementations(originalMethod, swizzledMethod);
}

#endif /* ThemeCommon_h */
