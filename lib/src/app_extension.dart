part of '../appstate_widget.dart';

/// Extension on numeric types (int, double) to add utility methods for limiting values within a specified range.
extension NumberLimiter<Number extends num> on Number {
  /// Returns the greater of this number and [min]. If this number is less than [min], [min] will be returned.
  Number min(Number min) => this < min ? min : this;

  /// Returns the lesser of this number and [max]. If this number is greater than [max], [max] will be returned.
  Number max(Number max) => this > max ? max : this;

  /// Returns this number, clamped to the range of [min] to [max].
  ///
  /// If this number is less than [min], [min] will be returned.
  /// If this number is greater than [max], [max] will be returned.
  /// Otherwise, this number will be returned unchanged.
  Number limit(Number min, Number max) => this < min
      ? min
      : this > max
          ? max
          : this;
}

/// Extensioning values used in [AppStateValue].
extension AppStateExtension on AppStateValue {
  /// A shortcut to call value from [AppStateValue.data].
  ///
  /// ```dart
  /// final controller = state.value<TextEditingController>('controller');
  /// print(controller.runtimeType); // TextEditingController
  /// ```
  T value<T extends Object?>(String key) => data[key] as T;
}

/// Extension on the Map<String, dynamic> value.
extension AppJson on JSON {
  /// The [value] method is used to retrieve a value of type `T` from the `JSON` object using a given [key].
  /// The [key] parameter is the key associated with the value to be retrieved.
  /// The method returns the value associated with the [key], casted to type `T`.
  /// If the key is not found or the value cannot be cast to type `T`, it returns `null`.
  ///
  /// Example:
  /// ```dart
  /// final data = {"name": "John", "age": 30};
  /// final name = data.of<String>("name"); // "John"
  /// final age = data.of<int>("age"); // 30
  /// final height = data.of<double>("height"); // null (key not found)
  /// ```
  T of<T extends Object?>(String key) => this[key] as T;
}
