part of '../dart_fusion.dart';

class DBehavior extends ScrollBehavior {
  const DBehavior({this.physics});
  final ScrollPhysics? physics;

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) => physics ?? const ClampingScrollPhysics();
}
