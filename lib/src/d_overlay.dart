part of '../dart_fusion.dart';

class DOverlay extends DStateWidget {
  DOverlay({
    super.key,
    this.duration = const Duration(milliseconds: 200),
    required this.child,
  });

  /// Duration for how much long does the value changes taking.
  final Duration duration;

  /// The widget to be displayed within the overlay.
  final Widget Function(
    BuildContext context,
    double progress,
    DOverlayController controller,
  ) child;

  /// Controller of [OverlayEntry].
  late final controller = DOverlayController(
    duration: duration,
    child: child,
  );

  @override
  Widget onStart(DStateValue state) => const SizedBox();

  @override
  void onFinish(DStateValue state) => controller.dispose();
}

/// A custom overlay that displays a widget on top of other content.
class DOverlayController extends OverlayEntry {
  /// The widget to be displayed within the overlay.
  final Widget Function(
    BuildContext context,
    double progress,
    DOverlayController controller,
  ) child;

  /// Creates an [DOverlay] with the provided [child].
  ///
  /// The [child] widget will be displayed on top of other content when the overlay is shown.
  DOverlayController({
    required this.duration,
    required this.child,
  }) : super(builder: (context) => const SizedBox());

  /// Animation state value, ranging from 0.0 to 1.0.
  final _animation = ValueNotifier(0.0);

  /// Duration for how much long does the value changes taking.
  final Duration duration;

  @override
  WidgetBuilder get builder => (context) => Material(
        color: Colors.transparent,
        child: ValueListenableBuilder(
          valueListenable: _animation,
          builder: (context, value, child) {
            return Stack(
              fit: StackFit.expand,
              children: [
                GestureDetector(
                  onTap: () {
                    _animation.value = 0.0;
                    Future.delayed(duration).then((value) => remove());
                  },
                  child: const ColoredBox(color: Colors.transparent),
                ),
                // Display the child widget
                this.child(context, value, this),
              ],
            );
          },
        ),
      );

  /// Displays the overlay.
  ///
  /// This method inserts the overlay into the widget tree to display the [child].
  void display(BuildContext context) {
    if (mounted) remove();
    Overlay.of(context).insert(this);
    Future.delayed(duration).then((value) => _animation.value = 1.0);
  }

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }
}
