part of '../dart_fusion_flutter.dart';

/// A builder widget that displays an overlay.
///
/// ```dart
/// final overlay = DOverlay(builder: (context, progress, controller) => YourWidget());
///
/// GestureDetector(
///   onTap: () {
///     overlay.controller.display(context);
///   }
/// );
/// ```
class DOverlay extends DWidget {
  /// Creates an instance of [DOverlay].
  ///
  /// [key] is a unique identifier for the widget.
  /// [duration] is the duration for the overlay animation (default is 200 milliseconds).
  /// [builder] is the widget to be displayed within the overlay.
  DOverlay({
    super.key,
    this.duration = const Duration(milliseconds: 200),
    required this.builder,
  });

  /// Duration for how much long does the value changes taking.
  final Duration duration;

  /// The widget to be displayed within the overlay.
  final Widget Function(
    BuildContext context,
    double progress,
    DOverlayController controller,
  ) builder;

  /// Controller of [OverlayEntry].
  late final controller = DOverlayController(
    duration: duration,
    child: builder,
  );

  @override
  Widget onStart(DState state) => const SizedBox();

  @override
  void onFinish(DState state) => controller.dispose();
}
