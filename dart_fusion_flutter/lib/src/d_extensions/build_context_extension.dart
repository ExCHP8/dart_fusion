part of '../../dart_fusion_flutter.dart';

/// A set of extension collection on [BuildContext].
extension BuildContextExtension on BuildContext {
  /// The [ThemeData] defined for this [BuildContext].
  ///
  /// ```dart
  /// ThemeData theme = context.theme;
  /// ```
  ThemeData get theme => Theme.of(this);

  /// The [ColorScheme] defined for the current [ThemeData].
  ///
  /// ```dart
  /// ColorScheme color = context.color;
  /// ```
  ColorScheme get color => theme.colorScheme;

  /// The [TextTheme] defined for the current [ThemeData].
  ///
  /// ```dart
  /// TextTheme text = context.text;
  /// ```
  TextTheme get text => theme.textTheme;

  /// The [BottomNavigationBarThemeData] defined for the current [ThemeData].
  BottomNavigationBarThemeData get bottomTheme =>
      theme.bottomNavigationBarTheme;

  /// The [MediaQueryData] for this [BuildContext].
  ///
  ///  ```dart
  /// MediaQuery query = context.query;
  /// ```
  MediaQueryData get query => MediaQuery.of(this);

  /// The size of the media query for this [BuildContext].
  ///
  /// ```dart
  /// Size suze = context.querySize;
  /// ```
  Size get querySize => MediaQuery.sizeOf(this);

  /// The height of the media query for this [BuildContext].
  ///
  /// ```dart
  /// double height = context.height;
  /// ```
  double get height => querySize.height;

  /// The width of the media query for this [BuildContext].
  ///
  /// ```dart
  /// double width = context.width;
  /// ```
  double get width => querySize.width;

  /// Returns `true` if the width of the media query for this [BuildContext]
  /// is less than 400.0, indicating it's a phone-sized device.
  ///
  /// ```dart
  /// bool isPhone = context.isPhone;
  /// ```
  bool get isPhone => width < 400.0;

  /// Returns `true` if the width of the media query for this [BuildContext]
  /// is greater than 700.0, indicating it's a desktop-sized device.
  ///
  /// ```dart
  /// bool isDesktop = context.isDesktop;
  /// ```
  bool get isDesktop => width > 700.0;

  /// Returns `true` if the width of the media query for this [BuildContext]
  /// is greater than 400.0 and less than 700.0, indicating it's a tablet-sized device.
  ///
  /// ```dart
  /// bool isTablet = context.isTablet;
  /// ```
  bool get isTablet => !isPhone && !isDesktop;

  /// Getting [DState] from its descendant.
  DState? get state => DInherited.of(this)?.value;

  /// A shortcut to get [DState.data] with [BuildContext].
  T? value<T extends Object?>(String key) => state?.value<T>(key);

  /// A shortcut to call [DProvider] of context.
  Object get provider => DProvider.of(this);
}
