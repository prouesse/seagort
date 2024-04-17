# Seagort
> NIMA Code: nima006

Seagort is a Dart Package for compiling JavaScript outside the web. With this package, you can write JavaScript Code and run it, producing the result as a `String`. 

This is the *main* version of seagort, (tagged *rust-seagort*, as it is the [rust](https://rust-lang.org/) implementation of the package library).

```dart
import 'package:seagort/seagort.dart';

void main() {
    print(compileJS('console.log("Hello, World!");'));
}
```

With this package you can compile JavaScript straight

For more on the engine that runs this package, check the `utils/engine` directory of this package.

## Issues
This README is used to track the ongoing issue for Linux on dart-lang/native#1087.