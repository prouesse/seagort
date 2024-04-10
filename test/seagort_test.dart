import 'package:seagort/seagort.dart';
import 'package:test/test.dart';

void main() {
  group('JS Tests', () {
    var a = 'console.log("Hello World")';
    var b = "9 + 18";
    var c = "'abacus'";
    var d = "const number = 89; console.log(number)";

    test("Results", () {
      expect(compileJS(a), equals("Hello World"));
      expect(compileJS(b), equals(""));
      expect(compileJS(c), equals(""));
      expect(compileJS(d), equals("89"));
    });
  });
}