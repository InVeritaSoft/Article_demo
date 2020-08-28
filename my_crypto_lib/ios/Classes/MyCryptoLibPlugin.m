#import "MyCryptoLibPlugin.h"
#if __has_include(<my_crypto_lib/my_crypto_lib-Swift.h>)
#import <my_crypto_lib/my_crypto_lib-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "my_crypto_lib-Swift.h"
#endif

@implementation MyCryptoLibPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftMyCryptoLibPlugin registerWithRegistrar:registrar];
}
@end
