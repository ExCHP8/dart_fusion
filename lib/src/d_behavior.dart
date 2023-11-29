part of '../dart_fusion_flutter.dart';

/// A custom scroll behavior for controlling the scrolling physics of scrollable widgets.
///
/// This class extends [ScrollBehavior] and allows you to customize the
/// [ScrollPhysics] used for scrolling within scrollable widgets like
/// [ListView], [GridView], or [SingleChildScrollView].
///
/// You can provide a custom [ScrollPhysics] instance through the `physics`
/// parameter, or it will default to [ClampingScrollPhysics] if not specified.
///
/// ```dart
/// MaterialApp(
///   scrollBehavior: DBehavior(
///     physics: BouncingScrollPhysics()),
///   home: ...,
/// );
///
/// ScrollConfiguration(
///   behavior: DBehavior(
///     physics: BouncingScrollPhysics()),
///   child: ListView(),
/// );
/// ```
class DBehavior extends ScrollBehavior {
  /// Creates a [DBehavior] instance with optional custom [ScrollPhysics].
  ///
  /// The [physics] parameter allows you to specify a custom [ScrollPhysics]
  /// instance for controlling scrolling behavior. If not provided, it defaults
  /// to [ClampingScrollPhysics].
  const DBehavior({this.physics});

  /// The custom [ScrollPhysics] instance to be used for scrolling.
  ///
  /// If not specified, it defaults to [ClampingScrollPhysics].
  final ScrollPhysics? physics;

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      physics ?? const ClampingScrollPhysics();
}
