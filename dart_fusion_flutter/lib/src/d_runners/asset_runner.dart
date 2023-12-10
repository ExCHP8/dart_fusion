part of '../../dart_fusion_flutter.dart';

/// Runner to scan asset and turn it into one model class.
class AssetRunner extends DRunner {
  /// Default constant constructor with [input] is `assets` and [output] is `lib/src/assets.dart`.
  const AssetRunner({this.input, this.output});

  /// Printing usage information of [AssetRunner].
  const AssetRunner.help()
      : input = null,
        output = null,
        super.help();

  @override
  String get name => 'Asset';

  /// Input directory of where the asset is. By default is `assets`.
  final Directory? input;

  /// Output file of where the generated model should take place. By default is `lib/src/assets.dart`.
  final File? output;

  @override
  List<String> get arguments => [
        if (input != null) ...['-i', input!.path],
        if (output != null) ...['-o', output!.path]
      ];
}
