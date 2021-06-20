#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "sspadsdk.h"

FOUNDATION_EXPORT double ssp_ios_sdk_publicVersionNumber;
FOUNDATION_EXPORT const unsigned char ssp_ios_sdk_publicVersionString[];

