import 'dart:ffi';
import 'package:ffi/ffi.dart';
import '../native/library.dart';
import '../source.dart';

String _compileJS(String data) {
  final _ = readLibrary();
  final nativeData = data.toNativeUtf8().cast<Char>();
  final result = compile_js(nativeData);
  return result.cast<Utf8>().toDartString();
}

Future<String> _compileJSAsync(String data) async {
  return Future.value(_compileJS(data));
}

String compileJavaSript(String js) => _compileJS(js);

Future<String> compileJavaScriptAsync(String js) async => _compileJSAsync(js);
