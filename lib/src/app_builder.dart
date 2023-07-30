part of '../appstate_widget.dart';

/// A widget that builds its child using a custom builder function with optional data.
///
/// The [data] parameter is an optional JSON object that can be used to pass data to the builder function.
/// The [builder] parameter is a required function that takes a [BuildContext] and [JSON] data, and returns a [Widget].
///
/// Example:
/// ```dart
/// AppBuilder(
///   data: {"name": "John", "age": 30},
///   builder: (context, data) {
///     final name = value["name"] as String;
///     final age = data["age"] as int;
///     return Text("My name is $name and I am $age years old.");
///   },
/// )
/// ```
class AppBuilder extends StatelessWidget {
  /// Creates an [AppBuilder] widget with the specified builder function and optional data.
  ///
  /// The [data] parameter is an optional JSON object that can be used to pass data to the builder function.
  /// The [builder] parameter is a required function that takes a [BuildContext] and [JSON] data, and returns a [Widget].
  const AppBuilder({super.key, this.data = const {}, required this.builder});

  /// The optional JSON data that can be passed to the builder function.
  final JSON data;

  /// The function that builds the child widget using the [BuildContext] and [JSON] data.
  final Widget Function(BuildContext context, JSON data) builder;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) => builder(context, data));
  }
}
