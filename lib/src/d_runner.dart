part of '../dart_fusion.dart';

/// The base abstract class for a [DRunner].
abstract class DRunner {
  /// Default constant constructor of [DRunner] with help as `false`.
  const DRunner() : help = false;

  /// Constant constructor for printing help.
  const DRunner.help() : help = true;

  /// The name of the runner.
  String get name;

  /// Choose wether to print help for this runner or not.
  final bool help;

  /// Gets the arguments for the runner as a list of strings.
  List<String> get arguments;

  /// Runs the Dart process for the runner wether [onDebug] only or on every profile.
  ///
  /// This method runs the Dart process using the 'dart' executable, passing the
  /// necessary arguments for the runner. It returns a [Future] containing the
  /// result of the process execution.
  ///
  /// The [arguments] are combined with the default 'run' and 'dart_fusion'
  /// arguments for execution.
  Future<void> run({bool onDebug = true}) async {
    if (onDebug ? kDebugMode : true) {
      await DProcess(name: name, arguments: arguments, help: help).run();
    }
  }
}

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

/// Runner to translate [Locale] and generate a model to be integrated with `easy_localization`.
class LocalizeRunner extends DRunner {
  /// Default constant constructor where the [input] by default is `assets/translation/en.json`,
  /// with default Locale
  /// [from] `en` and targetting list of Locale in [DartFusion.locales].
  const LocalizeRunner(
      {this.input,
      this.output,
      this.from = const Locale('en'),
      this.to = DartFusion.locales,
      this.translate = false,
      this.exclude = const []});

  /// Printing usage information of [LocalizeRunner].
  const LocalizeRunner.help()
      : input = null,
        output = null,
        from = null,
        to = null,
        exclude = null,
        translate = false,
        super.help();

  /// Input json default localization file. By default is `assets/translation/en.json`.
  final File? input;

  /// Output generated model to be integrated with `easy_localization`.
  final File? output;

  /// List of targeted translation. By default its [DartFusion.locales].
  final List<Locale>? to;

  /// List of excluded translation. By default its empty.
  final List<Locale>? exclude;

  /// Base Locale. By default is `Locale('en')`.
  final Locale? from;

  /// Choose whether to translate json to targetted locales or not.
  final bool translate;

  @override
  String get name => 'Localize';

  @override
  List<String> get arguments => [
        if (input != null) ...['-i', input!.path],
        if (output != null) ...['-o', output!.path],
        if (from != null) ...['--from', from!.languageCode],
        if (to != null) ...['--to', to!.map((e) => e.languageCode).join(',')],
        if (exclude != null) ...[
          '--exclude',
          exclude!.map((e) => e.languageCode).join(',')
        ],
        translate ? '--translate' : '--no-translate'
      ];
}

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
