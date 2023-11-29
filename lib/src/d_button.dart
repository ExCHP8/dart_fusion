part of '../dart_fusion_flutter.dart';

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
class DButton extends StatelessWidget {
  const DButton.text(
      {super.key,
      this.padding =
          const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.00),
      this.margin,
      this.color,
      this.borderRadius,
      this.ignore = false,
      required this.text,
      required this.onTap,
      this.prefix,
      this.suffix,
      this.gap = 10.0,
      this.style,
      this.focusColor,
      this.splashColor,
      this.hoverColor,
      this.highlightColor,
      this.shapeBorder,
      this.controller,
      this.textAlign,
      this.decoration,
      this.decorationPosition = DecorationPosition.background,
      this.mainAxisSize = MainAxisSize.min})
      : child = null;

  /// Creates a custom button widget with optional parameters for customization.
  ///
  /// The [padding] parameter specifies the padding around the button content.
  /// The [margin] parameter specifies the margin around the button.
  /// The [color] parameter sets the background color of the button.
  /// The [borderRadius] parameter determines the rounded corners of the button.
  /// The [ignore] parameter specifies whether the button should ignore tap interactions.
  /// The [onTap] parameter is the callback function triggered when the button is tapped.
  /// The [text] parameter provides the text to display inside the button.
  /// The [prefix] and [suffix] parameters are optional widgets to display before and after the text.
  /// The [gap] parameter sets the space between the text and prefix/suffix widgets.
  /// The [style] parameter allows you to customize the text style of the button text.
  /// The [focusColor], [splashColor], [hoverColor], and [highlightColor] parameters
  /// set the colors for specific material interaction states.
  /// The [shapeBorder] parameter allows you to customize the shape of the button material.
  /// The [controller] parameter provides a MaterialStatesController to manually control
  /// the interaction states of the material.
  /// The [mainAxisSize] parameter specifies the main axis size of the button.
  /// The [child] parameter allows you to provide a custom child widget for the button.
  ///
  /// By default, the [padding] is set to `EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0)`.
  /// The [mainAxisSize] is set to `MainAxisSize.min`.
  ///
  /// Example:
  /// ```dart
  /// DButton(
  ///   text: "Click Me",
  ///   color: Colors.blue,
  ///   onTap: () {
  ///     // Handle button tap event
  ///   },
  /// )
  /// ```
  const DButton({
    super.key,
    this.padding =
        const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.00),
    this.margin,
    this.color,
    this.borderRadius,
    this.ignore = false,
    this.focusColor,
    this.splashColor,
    this.hoverColor,
    this.highlightColor,
    this.shapeBorder,
    this.controller,
    this.decoration,
    this.decorationPosition = DecorationPosition.background,
    required this.onTap,
    required this.child,
  })  : text = '',
        mainAxisSize = null,
        prefix = null,
        suffix = null,
        gap = 0.0,
        style = null,
        textAlign = null;

  /// Alignment for [DButton.text].
  final TextAlign? textAlign;

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

  /// The text to display inside the button.
  final String text;

  /// An optional widget to display before the text.
  final Widget? prefix;

  /// An optional widget to display after the text.
  final Widget? suffix;

  /// The space between the text and prefix/suffix widgets.
  final double gap;

  /// The text style for the button text.
  final TextStyle? style;

  /// The main axis size of the button.
  final MainAxisSize? mainAxisSize;

  /// An optional custom child widget for the button.
  final Widget? child;

  /// The color when the material is focused.
  final Color? focusColor;

  /// The color when the material is splashed.
  final Color? splashColor;

  /// The color when the material is hovered.
  final Color? hoverColor;

  /// The color when the material is highlighted.
  final Color? highlightColor;

  /// The custom shape of the material.
  final ShapeBorder? shapeBorder;

  /// The controller to manually control the interaction states of the material.
  final MaterialStatesController? controller;

  /// Custom decoration for button.
  final BoxDecoration? decoration;

  /// Decoration Position by default on background
  final DecorationPosition decorationPosition;

  @override
  Widget build(BuildContext context) {
    final textWidget = Text(
      text,
      textAlign: textAlign,
      style: style ??
          context.text.bodyMedium?.copyWith(color: context.color.primary),
    );

    return AbsorbPointer(
      absorbing: ignore,
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: DecoratedBox(
          position: decorationPosition,
          decoration: (decoration ?? const BoxDecoration())
              .copyWith(borderRadius: borderRadius),
          child: InkMaterial(
            onTap: onTap,
            controller: controller,
            focusColor: focusColor,
            highlightColor: highlightColor,
            hoverColor: hoverColor,
            splashColor: splashColor,
            color: color,
            shapeBorder: shapeBorder,
            borderRadius: borderRadius,
            child: Padding(
              padding: padding ?? EdgeInsets.zero,
              child: child ??
                  Row(
                    mainAxisSize: mainAxisSize ?? MainAxisSize.min,
                    children: [
                      if (prefix != null)
                        Padding(
                          padding: EdgeInsets.only(right: gap),
                          child: prefix,
                        ),
                      if (text.isNotEmpty)
                        (mainAxisSize == MainAxisSize.max)
                            ? Expanded(child: textWidget)
                            : textWidget,
                      if (suffix != null)
                        Padding(
                          padding: EdgeInsets.only(left: gap),
                          child: suffix,
                        ),
                    ],
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
