part of '../dart_fusion_flutter.dart';

/// A set of extension collection on [BuildContext].
extension OnContext on BuildContext {
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

/// Extension on [ExpansionTile] providing a convenient method to create a copy
/// of the tile with modified properties.
///
/// Example usage:
/// ```dart
/// ExpansionTile originalTile = // your original tile;
/// ExpansionTile modifiedTile = originalTile.copyWith(
///   // modify properties here
/// );
/// ```
extension OnTile on ExpansionTile {
  /// Creates a copy of the [ExpansionTile] with modified properties.
  ///
  /// Parameters allow you to override specific properties of the original tile.
  /// If a parameter is not provided, the corresponding property from the
  /// original tile will be used.
  ExpansionTile copyWith({
    Key? key,
    Widget? leading,
    Widget? title,
    Widget? subtitle,
    void Function(bool)? onExpansionChanged,
    List<Widget>? children,
    Widget? trailing,
    bool? initiallyExpanded,
    bool? maintainState,
    EdgeInsetsGeometry? tilePadding,
    CrossAxisAlignment? expandedCrossAxisAlignment,
    Alignment? expandedAlignment,
    EdgeInsetsGeometry? childrenPadding,
    Color? backgroundColor,
    Color? collapsedBackgroundColor,
    Color? textColor,
    Color? collapsedTextColor,
    Color? iconColor,
    Color? collapsedIconColor,
    ShapeBorder? shape,
    ShapeBorder? collapsedShape,
    Clip? clipBehavior,
    ListTileControlAffinity? controlAffinity,
    ExpansionTileController? controller,
  }) {
    return ExpansionTile(
      key: key ?? this.key,
      leading: leading ?? this.leading,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      onExpansionChanged: onExpansionChanged ?? this.onExpansionChanged,
      trailing: trailing ?? this.trailing,
      initiallyExpanded: initiallyExpanded ?? this.initiallyExpanded,
      maintainState: maintainState ?? this.maintainState,
      tilePadding: tilePadding ?? this.tilePadding,
      expandedCrossAxisAlignment:
          expandedCrossAxisAlignment ?? this.expandedCrossAxisAlignment,
      expandedAlignment: expandedAlignment ?? this.expandedAlignment,
      childrenPadding: childrenPadding ?? this.childrenPadding,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      collapsedBackgroundColor:
          collapsedBackgroundColor ?? this.collapsedBackgroundColor,
      textColor: textColor ?? this.textColor,
      collapsedTextColor: collapsedTextColor ?? this.collapsedTextColor,
      iconColor: iconColor ?? this.iconColor,
      collapsedIconColor: collapsedIconColor ?? this.collapsedIconColor,
      shape: shape ?? this.shape,
      collapsedShape: collapsedShape ?? this.collapsedShape,
      clipBehavior: clipBehavior ?? this.clipBehavior,
      controlAffinity: controlAffinity ?? this.controlAffinity,
      controller: controller ?? this.controller,
      children: children ?? this.children,
    );
  }
}

/// Extensioning values used in [DState].
extension OnDState on DState {
  /// A shortcut to call value from [DState.data].
  ///
  /// ```dart
  /// final controller = state.value<TextEditingController>('controller');
  /// print(controller.runtimeType); // TextEditingController
  /// ```
  T value<T extends Object?>(String key) => data[key] as T;
}
