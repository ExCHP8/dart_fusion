part of '../dart_fusion.dart';

/// A generic InheritedWidget for providing a value of type [T] to its descendants.
///
/// The [DProvider] class extends [InheritedWidget] and is used to propagate a
/// value of type [T] down the widget tree. It is commonly used for providing
/// data, such as state or configuration, to various parts of the widget tree.
///
/// Example usage:
/// ```dart
/// DProvider<MyData>(
///   value: MyData(),
///   child: MyWidget(),
/// );
/// ```
class DProvider<T extends Object> extends InheritedWidget {
  /// Creates a [DProvider].
  ///
  /// The [value] parameter is the value of type [T] that will be provided to
  /// the descendants of this widget.
  ///
  /// The [child] parameter is the widget that will be the descendant and
  /// receive the provided value.
  const DProvider({
    Key? key,
    required this.value,
    required Widget child,
  }) : super(key: key, child: child);

  /// The value of type [T] that is provided to descendants.
  final T value;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;

  /// Retrieves the value of type [T] from the nearest ancestor [DProvider].
  ///
  /// Throws a [FlutterError] if no ancestor [DProvider] of type [T] is found.
  static T of<T extends Object>(BuildContext context) {
    final widget = context.dependOnInheritedWidgetOfExactType<DProvider<T>>();
    if (widget == null) {
      throw FlutterError("No DProvider<$T> found in context");
    }
    return widget.value;
  }
}
