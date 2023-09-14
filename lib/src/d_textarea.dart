part of '../dart_fusion.dart';

class DTextArea extends StatelessWidget {
  const DTextArea({
    super.key,
    this.placeholder,
    this.borderRadius,
    this.hintText,
    this.hintStyle,
    this.prefixIcon,
    this.contentPadding,
    this.backgroundColor,
    this.controller,
    this.borderSideActive,
    this.borderSideIdle,
    this.cursorColor,
    this.textStyle,
    this.textAlign = TextAlign.start,
    this.maxLines = 1,
    this.minLines,
    this.onSubmitted,
    this.labelStyle,
    this.labelText,
    this.margin,
    this.footer,
    this.decoration,
    this.suffixIcon,
  });

  /// If [placeholder] is not null, the textarea will follows [placeholder]
  /// size
  final Widget? placeholder;
  final BorderRadius? borderRadius;
  final String? hintText, labelText;
  final EdgeInsets? contentPadding, margin;
  final Widget? prefixIcon, suffixIcon, footer;
  final TextStyle? hintStyle, textStyle, labelStyle;
  final Color? backgroundColor, cursorColor;
  final TextEditingController? controller;
  final BorderSide? borderSideActive, borderSideIdle;
  final TextAlign textAlign;
  final int? maxLines;
  final int? minLines;
  final void Function(String)? onSubmitted;
  final BoxDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return DBuilder(
        data: {
          "text_area": Container(
              margin: margin,
              decoration: decoration ??
                  BoxDecoration(
                    color: backgroundColor ??
                        context.color.background.withOpacity(0.5),
                    borderRadius: borderRadius,
                  ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: TextField(
                        textAlign: textAlign,
                        controller: controller,
                        cursorColor: cursorColor ?? context.color.onBackground,
                        style: textStyle ??
                            context.text.bodyMedium
                                ?.copyWith(color: context.color.onBackground),
                        maxLines: maxLines,
                        minLines: minLines,
                        onSubmitted: onSubmitted,
                        decoration: InputDecoration(
                            hintText: hintText,
                            isDense: true,
                            labelText: labelText,
                            labelStyle: labelStyle,
                            contentPadding: contentPadding ?? EdgeInsets.zero,
                            suffixIcon: suffixIcon,
                            prefixIcon: prefixIcon,
                            hintStyle: hintStyle ??
                                context.text.bodyMedium?.copyWith(
                                    color: context.color.onBackground
                                        .withOpacity(0.5),
                                    height: 0.0),
                            focusedBorder: OutlineInputBorder(
                                borderSide: borderSideActive ??
                                    BorderSide(
                                        color: context.color.onBackground),
                                borderRadius:
                                    borderRadius ?? BorderRadius.circular(4.0)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: borderSideIdle ??
                                    BorderSide(color: context.color.outline),
                                borderRadius: borderRadius ??
                                    BorderRadius.circular(4.0)))),
                  ),
                  if (footer != null) footer!
                ],
              ))
        },
        builder: (context, data) {
          if (placeholder != null) {
            return Stack(children: [
              Visibility(
                  visible: false,
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  child: placeholder!),
              Positioned.fill(child: data.of<Widget>("text_area"))
            ]);
          } else {
            return data.of<Widget>("text_area");
          }
        });
  }
}
