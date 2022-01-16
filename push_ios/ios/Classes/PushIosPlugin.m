#import "PushIosPlugin.h"
#if __has_include(<push_ios/push_ios-Swift.h>)
#import <push_ios/push_ios-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "push_ios-Swift.h"
#endif

@implementation PushIosPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftPushIosPlugin registerWithRegistrar:registrar];
}
@end
