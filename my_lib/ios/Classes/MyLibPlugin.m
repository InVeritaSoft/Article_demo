#import "MyLibPlugin.h"
#if __has_include(<my_lib/my_lib-Swift.h>)
#import <my_lib/my_lib-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "my_lib-Swift.h"
#endif

@implementation MyLibPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftMyLibPlugin registerWithRegistrar:registrar];
}
@end
