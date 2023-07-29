part of '../appstate_widget.dart';

/// A simple logging utility for printing log messages with customizable log levels.
class AppLog {
  /// Creates a new [AppLog] instance with the given [message] and optional [level].
  /// By default, the log level is set to [Level.info].
  ///
  /// Example:
  /// ```dart
  /// AppLog("This is a log message", level: Level.warning);
  /// ```
  AppLog(this.message, {Level level = Level.info}) {
    Logger(printer: _AppLogPrinter(), level: level)
      ..log(level, message?.toString() ?? "No Message.")
      ..close();
  }

  /// The log message to be printed.
  final dynamic message;
}

/// The custom log printer for formatting log messages with colors based on the log level.
class _AppLogPrinter extends LogPrinter {
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
