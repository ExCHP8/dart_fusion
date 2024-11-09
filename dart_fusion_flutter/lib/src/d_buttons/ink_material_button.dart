part of '../../dart_fusion_flutter.dart';

/// A custom widget that combines [Material] and [InkWell] to provide
/// ink splash effects on taps.
class InkMaterial extends StatelessWidget {
  /// Creates an [InkMaterial] widget.
  ///
  /// The [child] is the content to display inside the material.
  /// The [color] sets the background color of the material.
  /// The [focusColor], [splashColor], [hoverColor], and [highlightColor]
  /// define the colors for different interaction states.
  /// The [borderRadius] defines the rounded corners of the material.
  /// The [shapeBorder] defines the custom shape of the material.
  /// The [controller] is used to control the interaction states manually.
  /// The [onTap] callback is triggered when the material is tapped.
  ///
  /// Example:
  /// ```dart
  /// InkMaterial(
  ///   color: Colors.blue,
  ///   borderRadius: BorderRadius.circular(10),
  ///   onTap: () {
  ///     // Add your onTap functionality here
  ///   },
  ///   child: Text('Tap Me'),
  /// )
  /// ```
  const InkMaterial({
    super.key,
    this.color,
    this.focusColor,
    this.splashColor,
    this.hoverColor,
    this.highlightColor,
    this.shapeBorder,
    this.controller,
    this.borderRadius,
    required this.onTap,
    required this.child,
  });

  /// The content to display inside the material.
  final Widget child;

  /// The background color of the material.
  final Color? color;

  /// The color when the material is focused.
  final Color? focusColor;

  /// The color when the material is splashed.
  final Color? splashColor;

  /// The color when the material is hovered.
  final Color? hoverColor;

  /// The color when the material is highlighted.
  final Color? highlightColor;

  /// The rounded corners of the material.
  final BorderRadius? borderRadius;

  /// The custom shape of the material.
  final ShapeBorder? shapeBorder;

  /// The callback function triggered when the material is tapped.
  final VoidCallback onTap;

  /// The controller to manually control the interaction states of the material.
  final WidgetStatesController? controller;

  @override
  Widget build(BuildContext context) => Material(
        borderRadius: borderRadius,
        color: color,
        shape: shapeBorder,
        child: InkWell(
          statesController: controller,
          borderRadius: borderRadius,
          customBorder: shapeBorder,
          onTap: onTap,
          focusColor: focusColor,
          splashColor: splashColor,
          hoverColor: hoverColor,
          highlightColor: highlightColor,
          child: child,
        ),
      );
}
