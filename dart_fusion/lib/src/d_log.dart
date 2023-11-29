part of '../dart_fusion.dart';

/// Enumeration representing different log levels for debugging and logging purposes.
enum DLevel {
  /// Verbose level, providing detailed diagnostic information.
  verbose,

  /// Debug level, used for debugging information.
  debug,

  /// Info level, used for informative messages.
  info,

  /// Warning level, used to indicate potential issues or unexpected behaviors.
  warning,

  /// Error level, used to indicate errors that do not prevent the application from running.
  error,

  /// WTF (What a Terrible Failure) level, used to indicate critical errors or unexpected conditions.
  wtf,

  /// No log level, effectively suppressing all log messages.
  nothing,
}

/// A simple logging utility for printing log messages with customizable log levels.
class DLog {
  /// Creates a new [DLog] instance with the given [message] and optional [level].
  /// By default, the log level is set to [Level.info].
  ///
  /// Example:
  /// ```dart
  /// AppLog("This is a log message", level: Level.warning);
  /// ```
  DLog(this.message, {DLevel level = DLevel.info}) {
    Logger(printer: _DLogPrinter(), level: Level.values[level.index])
      ..log(Level.values[level.index], message?.toString() ?? "No Message.")
      ..close();
  }

  /// The log message to be printed.
  final dynamic message;
}

/// The custom log printer for formatting log messages with colors based on the log level.
class _DLogPrinter extends LogPrinter {
  @override
  List<String> log(LogEvent event) {
    // Define ANSI color codes for different log levels
    const List<String> logColors = [
      "\x1b[37m", // verbose (default color)
      "\x1b[94m", // debug (blue)
      "\x1b[32m", // info (green)
      "\x1b[33m", // warning (yellow)
      "\x1b[91m", // error (red)
      "\x1b[35m", // wtf (magenta)
      "\x1b[37m", // nothing (default color)
    ];

    // Get the color code for the current log level
    String color = logColors[event.level.index];

    // Define log level prefixes
    const List<String> logPrefixes = [
      "VERBOSE",
      "DEBUG",
      "INFO",
      "WARNING",
      "ERROR",
      "WTF",
      "NOTHING",
    ];

    // Get the log level prefix for the current log event
    String prefix = logPrefixes[event.level.index];

    // Reset color code to default after printing the log message
    String close = "\x1b[0m";

    // Format the log message with color and prefix
    String formattedMessage = "$color[$prefix] ${event.message}$close";

    // Replace newline characters with color and prefix for multiline log messages
    formattedMessage = formattedMessage.replaceAll("\n", "\n$color[$prefix] ");

    return [formattedMessage];
  }
}
