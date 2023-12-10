part of '../../dart_fusion_flutter.dart';

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
