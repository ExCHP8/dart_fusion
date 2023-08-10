part of '../appstate_widget.dart';

class AppBehavior extends ScrollBehavior {
  const AppBehavior({this.physics});
  final ScrollPhysics? physics;

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) => physics ?? const ClampingScrollPhysics();
}
