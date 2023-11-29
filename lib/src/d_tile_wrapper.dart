part of '../dart_fusion_flutter.dart';

/// A wrapper around [ExpansionTile] that allows customization of its behavior.
///
/// The [DTileWrapper] class is a [StatefulWidget] that wraps an [ExpansionTile].
/// It provides customization of the initial expansion state and allows you to
/// respond to changes in the expansion state.
///
/// Example usage:
/// ```dart
/// DTileWrapper(
///   (isExpanded) => ExpansionTile(
///     title: Text('Tile Title'),
///     // Other ExpansionTile properties...
///   ),
/// );
/// ```
class DTileWrapper extends StatefulWidget {
  /// Creates a [DTileWrapper] with the specified [builder] function.
  ///
  /// The [builder] function takes a boolean `isExpanded` parameter, indicating
  /// the current expansion state, and returns an [ExpansionTile] widget.
  const DTileWrapper(
    this.builder, {
    Key? key,
  }) : super(key: key);

  /// The function that builds the [ExpansionTile] widget with customization.
  final ExpansionTile Function(bool isExpanded) builder;

  @override
  State<DTileWrapper> createState() => _DTileWrapperState();
}

class _DTileWrapperState extends State<DTileWrapper> {
  /// The current expansion state of the tile.
  late bool value = widget.builder(false).initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    ExpansionTile child = widget.builder(value);
    return child.copyWith(onExpansionChanged: (value) {
      setState(() => this.value = value);
      child.onExpansionChanged?.call(this.value);
    });
  }
}
