import 'funcs.dart';

class SystemArchitecture {
  static bool get isARM => getArchitecture().contains('arm');
  static bool get isAMD => getArchitecture().contains('amd');
  static bool get isX64 => getArchitecture().contains('x64');
  static bool get isX32 => getArchitecture().contains('x32');
  static bool get isX86 => getArchitecture().contains('x86');

  static String get architecture => getArchitecture();
}
