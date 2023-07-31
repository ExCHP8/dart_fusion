part of '../appstate_widget.dart';

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
  final MaterialStatesController? controller;

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

/// A custom button widget that wraps the [InkMaterial] widget to provide
/// tap interactions with various customization options.
class AppButton extends StatelessWidget {
  /// Creates an [AppButton] widget.
  ///
  /// The [child] is the content to display inside the button.
  /// The [padding] sets the padding around the button content.
  /// The [margin] sets the margin around the button.
  /// The [color] sets the background color of the button.
  /// The [borderRadius] defines the rounded corners of the button.
  /// The [ignore] determines whether the button should ignore tap interactions.
  /// The [onTap] callback is triggered when the button is tapped.
  ///
  /// Example:
  /// ```dart
  /// AppButton(
  ///   color: Colors.blue,
  ///   borderRadius: BorderRadius.circular(10),
  ///   onTap: () {
  ///     // Add your onTap functionality here
  ///   },
  ///   child: Text('Tap Me'),
  /// )
  /// ```
  const AppButton({
    super.key,
    this.padding,
    this.margin,
    this.color,
    this.borderRadius,
    this.ignore = false,
    required this.onTap,
    required this.child,
  });

  /// The content to display inside the button.
  final Widget child;

  /// The padding around the button content.
  final EdgeInsets? padding;

  /// The margin around the button.
  final EdgeInsets? margin;

  /// The background color of the button.
  final Color? color;

  /// The rounded corners of the button.
  final BorderRadius? borderRadius;

  /// Determines whether the button should ignore tap interactions.
  final bool ignore;

  /// The callback function triggered when the button is tapped.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: ignore,
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: InkMaterial(
          onTap: onTap,
          color: color,
          borderRadius: borderRadius,
          child: Padding(padding: padding ?? EdgeInsets.zero, child: child),
        ),
      ),
    );
  }

  /// A convenient method to create a general button with text and optional
  /// prefix and suffix widgets.
  ///
  /// The [onTap] is the callback function when the button is tapped.
  /// The [text] is the text to display inside the button.
  /// The [padding] sets the padding around the button content.
  /// The [gap] sets the gap between the prefix and suffix widgets.
  /// The [color] sets the background color of the button.
  /// The [borderRadius] defines the rounded corners of the button.
  /// The [margin] sets the margin around the button.
  /// The [style] sets the text style of the button text.
  /// The [prefix] is a widget displayed before the text.
  /// The [suffix] is a widget displayed after the text.
  /// The [ignore] determines whether the button should ignore tap interactions.
  ///
  /// Example:
  /// ```dart
  /// AppButton.general(
  ///   onTap: () {
  ///     // Add your onTap functionality here
  ///   },
  ///   text: 'Tap Me',
  ///   color: Colors.blue,
  ///   borderRadius: BorderRadius.circular(10),
  /// )
  /// ```
  static Widget general({
    required VoidCallback onTap,
    required String text,
    EdgeInsets padding =
        const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.00),
    double gap = 10.0,
    Color? color,
    BorderRadius? borderRadius,
    EdgeInsets? margin,
    TextStyle? style,
    Widget? prefix,
    Widget? suffix,
    bool ignore = false,
  }) {
    return Builder(
      builder: (context) => AppButton(
        onTap: onTap,
        ignore: ignore,
        color: color,
        margin: margin,
        borderRadius: borderRadius ?? BorderRadius.circular(10.0),
        padding: padding,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (prefix != null)
              Padding(
                padding: EdgeInsets.only(right: gap),
                child: prefix,
              ),
            Text(
              text,
              style: style ??
                  context.text.bodyMedium
                      ?.copyWith(color: context.color.primary),
            ),
            if (suffix != null)
              Padding(
                padding: EdgeInsets.only(left: gap),
                child: suffix,
              ),
          ],
        ),
      ),
    );
  }
}
