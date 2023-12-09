part of '../../dart_fusion.dart';

/// Base dart model which consist `copyWith`, `toJSON`, `fromJSON` and `toString` value;
///
/// ```dart
/// class NewDModel extends DModel {}
/// ```
class DModel extends Equatable {
  /// Default constructor
  const DModel();

  /// Copy variables in this DModel and make a new one out of it.
  ///
  /// ```dart
  /// DModel DModel = const DModel();
  /// DModel newDModel = DModel.copyWith();
  /// ```
  DModel copyWith() => const DModel();

  /// Convert this DModel to JSON.
  ///
  /// ```dart
  /// DModel DModel = const DModel();
  /// JSON json = DModel.toJSON;
  /// ```
  JSON get toJSON => {'model_type': runtimeType.toString()};

  /// Override toJSON value
  set toJSON(JSON toJSON) => this.toJSON = toJSON;

  /// Convert a JSON to this DModel.
  ///
  /// ```dart
  /// DModel model = DModel.fromJSON(json);
  /// ```
  static DModel fromJSON(JSON value) => const DModel();

  /// A Dummy test model value.
  ///
  /// ```dart
  /// DModel test = Dmodel.test;
  /// ```
  static DModel get test {
    return const DModel();
  }

  @override
  List<Object?> get props =>
      toJSON.entries.map((e) => '${e.key}: ${e.value}').toList();

  @override
  String toString() =>
      runtimeType.toString() +
      toJSON.entries.map((e) => '${e.key}: ${e.value}').toString();
}
