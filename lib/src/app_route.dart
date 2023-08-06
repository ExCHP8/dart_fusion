part of '../appstate_widget.dart';

/// A custom route for handling navigation within the application.
///
/// Extends [GoRoute] to provide additional functionality.
class AppRoute extends GoRoute {
  /// Creates an [AppRoute] instance with the specified [path].
  ///
  /// The [path] parameter is the route path to be matched for navigation.
  /// The [builder] parameter is an optional function that returns a widget to be built when the route is navigated to.
  AppRoute({
    this.baseURL = "http://localhost:8080",
    required String path,
    Widget Function(BuildContext context, GoRouterState state)? builder,
  }) : super(path: path, builder: builder);
  final String baseURL;

  @override
  Widget Function(BuildContext context, GoRouterState state)? get builder {
    if (super.builder != null) {
      return (BuildContext context, GoRouterState state) {
        AppLog("$baseURL${state.location}");
        return super.builder!(context, state);
      };
    }
    return super.builder;
  }
}
