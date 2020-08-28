import 'dart:ffi'; // For FFI
import 'dart:io'; // For Platform.isX

final DynamicLibrary nativeCryptoLib = Platform.isAndroid
    ? DynamicLibrary.open('libmy_crypto_lib.so')
    : DynamicLibrary.process();

class MyCryptoLib {

  final int Function(int x, int y) nativeCrypto =
    nativeCryptoLib
      .lookup<NativeFunction<Int32 Function(Int32, Int32)>>("native_add")
      .asFunction();

}
