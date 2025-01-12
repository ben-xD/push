#if TARGET_OS_IOS
#import <Flutter/Flutter.h>
#endif
#if TARGET_OS_OSX
#import <FlutterMacOS/FlutterMacOS.h>
#endif

@interface PushPlugin : NSObject <FlutterPlugin>
@end