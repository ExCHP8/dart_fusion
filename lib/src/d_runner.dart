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
  Future<ProcessResult?> run({bool onDebug = true}) async {
    if (onDebug ? kDebugMode : true) {
      try {
        final process = await Process.run(
            'dart',
            [
              'run',
              'dart_fusion',
              name.toLowerCase(),
              if (help) '-h' else ...arguments,
            ],
            runInShell: true);
        print('\x1B[33m[$name]\x1B[0m ${process.stdout}${process.stderr}');
        return process;
      } catch (e) {
        print(e);
        return null;
      }
    }
    return null;
  }
}

class AssetRunner extends DRunner {
  const AssetRunner({required this.input, required this.output});

  const AssetRunner.help()
      : input = '',
        output = '',
        super.help();

  @override
  String get name => 'Asset';

  /// Input directory of where the asset is. By default is `assets`.
  final String input;

  /// Output directory of where the generated model should take place. By default is `lib/src/assets.dart`.
  final String output;

  @override
  List<String> get arguments => ['-i $input', '-o $output'];
}

class LocalizeRunner extends DRunner {
  const LocalizeRunner({
    required this.input,
    this.output,
    required this.from,
    required this.to,
  });

  const LocalizeRunner.help()
      : input = '',
        output = '',
        from = const Locale('en'),
        to = const [],
        super.help();

  final String input;
  final String? output;
  final List<Locale> to;
  final Locale from;

  @override
  String get name => 'Localize';

  @override
  List<String> get arguments => [
        '-i $input',
        if (output != null) '-o $output',
        '--from ${from.languageCode}',
        '--to ${to.map((e) => e.languageCode).toList()}'
      ];
}

class ModelRunner extends DRunner {
  const ModelRunner({required this.input}) : super();

  const ModelRunner.help()
      : input = '',
        super.help();

  /// Input directory of where the models in.
  ///
  /// By default should be [Directory.current.path].
  final String input;

  @override
  String get name => 'Model';

  @override
  List<String> get arguments => ['-i $input'];
}
