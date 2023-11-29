part of '../dart_fusion_flutter.dart';

/// A widget that logs a message using [DLog] and then returns a child widget.
///
/// The [message] to log can be of any type.
///
/// The [level] of the log message, defaults to [DLevel.info].
///
/// The [child] is the widget to return after logging the message.
class DLogWidget extends StatelessWidget {
  /// Creates a [DLogWidget] with the specified [message], [level], and [child].
  const DLogWidget(
    this.message, {
    Key? key,
    this.level = DLevel.info,
    required this.child,
    this.onDebug = kDebugMode,
  }) : super(key: key);

  /// Choose wether print log on debug or anytime.
  final bool onDebug;

  /// The child widget to return after logging the message.
  final Widget child;

  /// The message to log.
  final dynamic message;

  /// The log level, defaults to [DLevel.info].
  final DLevel level;

  @override
  Widget build(BuildContext context) {
    if (onDebug) DLog(message, level: level);
    return child;
  }
}
