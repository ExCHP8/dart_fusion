// ignore_for_file: deprecated_member_use

part of '../appstate_widget.dart';

/// A custom widget for displaying images with optional parameters for size, fit, and color.
class AppImage<Source extends Object> extends StatelessWidget {
  /// Creates an [AppImage] widget with the specified [source].
  ///
  /// The [source] parameter is the path or URL of the image to be displayed.
  /// The [size] parameter is the desired size of the image.
  /// The [fit] parameter specifies how the image should be inscribed into the space allocated for it.
  /// The [color] parameter is used to apply a color filter to the image.
  /// The [colorBlendMode] parameter determines how the [color] should be blended with the image.
  /// The [alignment] parameter specifies how the image should be aligned within its container.
  /// The [colorFilter] parameter is used to apply a color filter to the image.
  /// The [placeholderBuilder] parameter is used to build a placeholder widget while the image is being loaded.
  /// The [semanticsLabel] parameter is used to provide a description of the image for accessibility purposes.
  /// The [errorBuilder] parameter is used to build a widget when the image fails to load.
  const AppImage({
    super.key,
    required this.source,
    this.size,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.color,
    this.colorBlendMode,
    this.colorFilter,
    this.placeholderBuilder,
    this.semanticsLabel,
    this.errorBuilder,
  });

  /// The source of the image to be displayed.
  final Source source;

  /// The desired size of the image.
  final Size? size;

  /// How the image should be inscribed into the space allocated for it.
  final BoxFit fit;

  /// A color filter to apply to the image.
  final Color? color;

  /// The blending mode to apply to the [color].
  final BlendMode? colorBlendMode;

  /// The alignment of the image within its container.
  final Alignment alignment;

  /// A color filter to apply to the image.
  final ColorFilter? colorFilter;

  /// A builder function to create a placeholder widget while the image is being loaded.
  final Widget Function(BuildContext)? placeholderBuilder;

  /// A description of the image for accessibility purposes.
  final String? semanticsLabel;

  /// A builder function to create a widget when the image fails to load.
  final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;

  @override
  Widget build(BuildContext context) {
    try {
      // if (source is File) {
      //   final source = this.source as File;
      //   if (source.path.endsWith(".svg")) {
      //     return SvgPicture.file(
      //       source,
      //       width: size?.width,
      //       height: size?.height,
      //       fit: fit,
      //       alignment: alignment,
      //       placeholderBuilder: placeholderBuilder,
      //       semanticsLabel: semanticsLabel,
      //       color: color,
      //       colorBlendMode: colorBlendMode ?? BlendMode.srcIn,
      //     );
      //   } else {
      //     return Image.file(source,
      //         width: size?.width,
      //         height: size?.height,
      //         fit: fit,
      //         alignment: alignment,
      //         errorBuilder: errorBuilder, frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
      //       if (placeholderBuilder != null && frame == null) {
      //         return placeholderBuilder!(context);
      //       }
      //       return child;
      //     }, semanticLabel: semanticsLabel, color: color, colorBlendMode: colorBlendMode);
      //   }
      // } else 
      if (source is Uint8List) {
        final source = this.source as Uint8List;
        try {
          return SvgPicture.memory(
            source,
            width: size?.width,
            height: size?.height,
            fit: fit,
            alignment: alignment,
            placeholderBuilder: placeholderBuilder,
            semanticsLabel: semanticsLabel,
            color: color,
            colorBlendMode: colorBlendMode ?? BlendMode.srcIn,
          );
        } catch (e) {
          return Image.memory(source,
              width: size?.width,
              height: size?.height,
              fit: fit,
              alignment: alignment,
              errorBuilder: errorBuilder, frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
            if (placeholderBuilder != null && frame == null) {
              return placeholderBuilder!(context);
            }
            return child;
          }, semanticLabel: semanticsLabel, color: color, colorBlendMode: colorBlendMode);
        }
      } else {
        final source = this.source.toString();
        if (source.startsWith("http")) {
          if (source.endsWith(".svg")) {
            return SvgPicture.network(
              source,
              width: size?.width,
              height: size?.height,
              fit: fit,
              alignment: alignment,
              placeholderBuilder: placeholderBuilder,
              semanticsLabel: semanticsLabel,
              color: color,
              colorBlendMode: colorBlendMode ?? BlendMode.srcIn,
            );
          } else {
            return Image.network(source,
                width: size?.width,
                height: size?.height,
                fit: fit,
                alignment: alignment,
                errorBuilder: errorBuilder, frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
              if (placeholderBuilder != null && frame == null) {
                return placeholderBuilder!(context);
              }
              return child;
            }, semanticLabel: semanticsLabel, color: color, colorBlendMode: colorBlendMode);
          }
        } else {
          final source = this.source as String;
          if (source.endsWith(".svg")) {
            return SvgPicture.asset(
              source,
              width: size?.width,
              height: size?.height,
              fit: fit,
              alignment: alignment,
              placeholderBuilder: placeholderBuilder,
              semanticsLabel: semanticsLabel,
              color: color,
              colorBlendMode: colorBlendMode ?? BlendMode.srcIn,
            );
          } else {
            return Image.asset(source,
                width: size?.width,
                height: size?.height,
                fit: fit,
                alignment: alignment,
                errorBuilder: errorBuilder,
                semanticLabel: semanticsLabel, frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
              if (placeholderBuilder != null && frame == null) {
                return placeholderBuilder!(context);
              }
              return child;
            }, color: color, colorBlendMode: colorBlendMode);
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        AppLog(e, level: Level.error);
      }
      return const SizedBox();
    }
  }

  /// Creates a copy of this [AppImage] but with the given fields replaced with the new values.
  ///
  /// If any of the provided parameters are null, the original value from this [AppImage] will be used.
  AppImage<Source> copyWith({
    Source? source,
    Size? size,
    BoxFit? fit,
    Alignment? alignment,
    Color? color,
    BlendMode? colorBlendMode,
    ColorFilter? colorFilter,
    Widget Function(BuildContext)? placeholderBuilder,
    String? semanticsLabel,
    Widget Function(BuildContext, Object, StackTrace?)? errorBuilder,
  }) {
    return AppImage<Source>(
      source: source ?? this.source,
      size: size ?? this.size,
      fit: fit ?? this.fit,
      alignment: alignment ?? this.alignment,
      color: color ?? this.color,
      colorBlendMode: colorBlendMode ?? this.colorBlendMode,
      colorFilter: colorFilter ?? this.colorFilter,
      placeholderBuilder: placeholderBuilder ?? this.placeholderBuilder,
      semanticsLabel: semanticsLabel ?? this.semanticsLabel,
      errorBuilder: errorBuilder ?? this.errorBuilder,
    );
  }
}
