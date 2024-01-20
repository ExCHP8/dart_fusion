part of '../../dart_fusion.dart';

/// Extension on [String] to provide additional functionality.
extension StringExtension on String {
  /// Replaces occurrences of keys with their respective values from the provided map.
  ///
  /// [key] is a map of string keys and their corresponding values to replace in the string.
  ///
  /// Returns a new string with replaced values.
  String add({required Map<String, String> key}) =>
      key.entries.fold(this, (output, entry) {
        return output.replaceAll(entry.key, entry.value);
      });

  /// Capitalizes the first letter of the string.
  ///
  /// Returns the string with the first letter capitalized.
  ///
  /// ```dart
  /// String word = 'magnificent'.toCamelCase();
  /// print(word); // Magnificent
  /// ```
  String toCamelCase() {
    try {
      return this[0].toUpperCase() + substring(1, length);
    } catch (e) {
      return toString().toUpperCase();
    }
  }

  /// Checks whether the [String] adheres to the standard email format.
  ///
  /// Returns `true` if the [String] represents a valid email address,
  /// otherwise returns `false`.
  bool get isEmail {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z]{2,})+$')
        .hasMatch(this);
  }

  /// Try parse [bool] from [String].
  bool? toBool() => bool.tryParse(this);

  /// Try parse [DateTime] from [String].
  DateTime? toDateTime() => DateTime.tryParse(this);

  /// Try parse [int] from [String].
  int? toInt() => int.tryParse(this);

  /// Try parse [double] from [String].
  double? toDouble() => double.tryParse(this);

  /// Try parse [Duration] from [String].
  Duration? toDuration({DurationType type = DurationType.seconds}) =>
      int.tryParse(this)?.toDuration(type: type);
}
