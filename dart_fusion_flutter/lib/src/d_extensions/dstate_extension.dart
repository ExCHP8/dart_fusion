part of '../../dart_fusion_flutter.dart';

/// Extensioning values used in [DState].
extension DStateExtension on DState {
  /// A shortcut to call value from [DState.data].
  ///
  /// ```dart
  /// final controller = state.value<TextEditingController>('controller');
  /// print(controller.runtimeType); // TextEditingController
  /// ```
  T value<T extends Object?>(String key) => data[key] as T;
}
