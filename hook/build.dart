import 'dart:io';

import 'package:native_assets_cli/native_assets_cli.dart';

const assetName = 'libseagort.so';
final packageAssetPath = Uri.file('bridge/linux/$assetName');

void main(List<String> args) async {
  await build(args, (config, output) async {
    final packageName = config.packageName;
    final assetPath = config.outputDirectory.resolve(assetName);
    final assetSourcePath = config.packageRoot.resolveUri(packageAssetPath);
    if (!config.dryRun) {
      // Insert code that downloads or builds the asset to `assetPath`.
      await File.fromUri(assetSourcePath).copy(assetPath.toFilePath());

      output.addDependencies([
        assetSourcePath,
        config.packageRoot.resolve('hook/build.dart'),
      ]);
    }

    output.addAsset(
      NativeCodeAsset(
        package: packageName, 
        name: assetName, 
        file: assetPath,
        linkMode: DynamicLoadingBundled(), 
        os: config.targetOS,
        architecture: config.targetArchitecture,
      )
    );
  });
}
