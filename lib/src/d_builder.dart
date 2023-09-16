part of '../dart_fusion.dart';

/// A widget that builds its child using a custom builder function with optional data.
///
/// Example:
/// ```dart
/// DBuilder(
///   data: {"name": "John", "age": 30},
///   builder: (context, data) {
///     final name = data.of<String>("name");
///     final age = data.of<int>("age");
///     return Text("My name is $name and I am $age years old.");
///   },
/// )
/// ```
class DBuilder extends StatelessWidget {
  /// Creates an [DBuilder] widget with the specified builder function and optional data.
  ///
  /// The [data] parameter is an optional JSON object that can be used to pass
  /// data to the builder function.
  /// The [builder] parameter is a required function that takes
  /// a [BuildContext] and [JSON] data, and returns a [Widget].
  ///
  /// Example:
  /// ```dart
  /// DBuilder(
  ///   data: {"name": "John", "age": 30},
  ///   builder: (context, data) {
  ///     final name = data.of<String>("name");
  ///     final age = data.of<int>("age");
  ///     return Text("My name is $name and I am $age years old.");
  ///   },
  /// )
  /// ```
  const DBuilder({
    super.key,
    this.data = const {},
    required this.builder,
  });

  /// The optional JSON data that can be passed to the builder function.
  final JSON data;

  /// The function that builds the child widget using the [BuildContext] and [JSON] data.
  final Widget Function(
    BuildContext context,
    JSON data,
  ) builder;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) => builder(context, data));
  }
}
