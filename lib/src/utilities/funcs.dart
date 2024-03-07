import 'dart:convert';
import 'dart:io';

String getArchitecture() {
  if (!Platform.isWindows) {
    final result = Process.runSync('uname', ['-m']);
    return result.stdout.toString();
  }
  else {
    final result = getWindowsInfo();
    return _processSystemInfo(result);
  }
}

String _processSystemInfo(String result) {
  final splitter = LineSplitter().convert(result);
  final archLine = splitter.firstWhere((element) => element.contains("System Type:"));
  if (archLine.contains('x64')) return 'x64';
  else if (archLine.contains('x32')) return 'x32';
  else if (archLine.contains('x86')) return 'x86';
  else if (archLine.contains('arm64')) return 'arm64';
  else return 'unknown';
}

String getWindowsInfo() {
  if (!Platform.isWindows) {
    throw new Exception("Platform must be windows");
  } else {
    final result = Process.runSync('systeminfo', []);
    return result.stdout.toString();
    
  }
}