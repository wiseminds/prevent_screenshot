#import "PreventScreenshotPlugin.h"
#if __has_include(<prevent_screenshot/prevent_screenshot-Swift.h>)
#import <prevent_screenshot/prevent_screenshot-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "prevent_screenshot-Swift.h"
#endif

@implementation PreventScreenshotPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftPreventScreenshotPlugin registerWithRegistrar:registrar];
}
@end
