part of '../../dart_fusion_flutter.dart';

/// Runner to completing [DModel], like `copyWith`, `fromJSON` and `toJSON`.
class ModelRunner extends DRunner {
  /// Default constant consturctor with [input] scanning from root directory of project.
  const ModelRunner({this.input});

  /// Printing usage information of [ModelRunner].
  const ModelRunner.help()
      : input = null,
        super.help();

  /// Input directory of where the models in.
  ///
  /// By default should be [Directory.current].
  final Directory? input;

  @override
  String get name => 'Model';

  @override
  List<String> get arguments => [
        if (input != null) ...['-i', input!.path]
      ];
}
