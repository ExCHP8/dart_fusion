part of '../dart_fusion.dart';

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
extension AppStateExtension on DStateValue {
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
  /// Merge between one [JSON] to another, usefull for values with same key in
  /// a [JSON] structure.
  JSON merge(JSON other) {
    final result = <String, dynamic>{};

    for (final key in keys) {
      if (other.containsKey(key) && this[key] is JSON && other[key] is JSON) {
        result[key] = (this[key] as JSON).merge(other[key] as JSON);
      } else {
        result[key] = this[key];
      }
    }

    for (final key in other.keys) {
      if (!result.containsKey(key)) {
        result[key] = other[key];
      }
    }

    return result;
  }

  /// Parse `dynamic` value to given [T] with an optional [onError] fallback.
  T of<T extends Object>(String key, [T? onError]) {
    T onElse() {
      if (T is int) {
        return 0 as T;
      } else if (T is double) {
        return 0.0 as T;
      } else if (T is bool) {
        return false as T;
      } else if (T is String) {
        return '' as T;
      } else if (T is JSON) {
        return <JSON>{} as T;
      } else if (T is List) {
        return <dynamic>[] as T;
      } else if (T is DateTime) {
        return DateTime.now() as T;
      } else {
        throw const FormatException('Type is not provided, use <JSON>{}.maybeOf("key") instead.');
      }
    }

    return this[key] as T? ?? onError ?? onElse();
  }

  /// Parse `dynamic` value as a nullable [Type].
  T? maybeOf<T extends Object>(String key) {
    return this[key] as T?;
  }
}

/// Extension on [BuildContext] to provide easy access to common theming and
/// media query properties.
extension OnContext on BuildContext {
  /// The [ThemeData] defined for this [BuildContext].
  ThemeData get theme => Theme.of(this);

  /// The [ColorScheme] defined for the current [ThemeData].
  ColorScheme get color => theme.colorScheme;

  /// The [TextTheme] defined for the current [ThemeData].
  TextTheme get text => theme.textTheme;

  /// The [BottomNavigationBarThemeData] defined for the current [ThemeData].
  BottomNavigationBarThemeData get bottomTheme => theme.bottomNavigationBarTheme;

  /// The [MediaQueryData] for this [BuildContext].
  MediaQueryData get query => MediaQuery.of(this);

  /// The size of the media query for this [BuildContext].
  Size get querySize => MediaQuery.sizeOf(this);

  /// The height of the media query for this [BuildContext].
  double get height => querySize.height;

  /// The width of the media query for this [BuildContext].
  double get width => querySize.width;

  /// Returns `true` if the width of the media query for this [BuildContext]
  /// is less than 600.0, indicating it's a phone-sized device.
  bool get isPhone => width < 400.0;

  /// Returns `true` if the width of the media query for this [BuildContext]
  /// is greater than 700.0, indicating it's a desktop-sized device.
  bool get isDesktop => width > 700.0;

  /// Returns `true` if the width of the media query for this [BuildContext]
  /// is greater than 600.0 and less than 700.0, indicating it's a tablet-sized device.
  bool get isTablet => !isPhone && !isDesktop;

  /// Getting [AppStateValue] from its descendant.
  DStateValue? get appstate => DStateInherited.of(this)?.value;

  /// A shortcut to get [AppStateValue.data] with [BuildContext].
  T? value<T extends Object?>(String key) => appstate?.value<T>(key);
}

/// Extensioning generic [List] value.
extension ListExtension<OldValue extends Object?> on List<OldValue> {
  /// Generate index and item of a [List].
  ///
  /// ```dart
  /// List<String> texts = ["one", "two", "three"];
  /// List<Widget> widgets = texts.to((index, item) => Text("$index: $item"));
  /// ```
  List<NewValue> to<NewValue extends Object?>(NewValue Function(int index, OldValue item) value) =>
      asMap().entries.map<NewValue>((map) => value(map.key, map.value)).toList();

  /// A shortcut of extended sublits with safety.
  List<OldValue> limit(int start, int length) {
    final end = start + length;
    return start > this.length
        ? this
        : end > this.length
            ? sublist(start, this.length)
            : sublist(start, end);
  }
}

/// An extension of [DModel] list.
extension ListModelExtension on List<DModel> {
  /// A shortcut to call [toJSON] from [DModel].
  List<JSON> get toJSON => map((e) => e.toJSON).toList();

  /// A shortcut to add new [DModel] into list of [DModel].
  List<DModel> add(DModel value) => [...this, value];
}

extension GoRouteExtension on GoRoute {
  GoRoute add({required Map<String, String> key}) => GoRoute(
      path: key.entries.fold(path, (output, entry) {
        return output.replaceAll(entry.key, entry.value);
      }),
      builder: builder);
}

extension StringExtension on String {
  String add({required Map<String, String> key}) => key.entries.fold(this, (output, entry) {
        return output.replaceAll(entry.key, entry.value);
      });
}
