import 'dart:ffi'; // For FFI
import 'dart:io'; // For Platform.isX

final DynamicLibrary nativeMyLib = Platform.isAndroid
    ? DynamicLibrary.open('libmy_lib.so')
    : DynamicLibrary.process();

class MyLib {

  final int Function(int x, int y) nativeAdd =
  nativeMyLib
      .lookup<NativeFunction<Int32 Function(Int32, Int32)>>("native_add")
      .asFunction();

}