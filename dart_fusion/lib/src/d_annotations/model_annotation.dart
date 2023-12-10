part of '../../dart_fusion.dart';

/// Annotation of class as an indicator to generate a [fromJSON],
/// [toJSON] and [copyWith] inside the annotated class.
///
/// ```dart
/// @model
/// class MyClass extends DModel {}
///
/// // or you can annotate it like this
///
/// @Model(immutable: false, copyWith: false)
/// class MyClass extends DModel {}
/// ```
class Model {
  /// Default constructor of [Model], with [immutable] defaults to `true`,
  /// [toJSON] defaults to `true`, [copyWith] defaults to `true`,
  /// [fromJSON] defaults to `true`.
  const Model({
    this.immutable = true,
    this.toJSON = true,
    this.copyWith = true,
    this.fromJSON = true,
    this.test = true,
  });

  /// Indicates whether code for JSON serialization should be generated or not.
  final bool toJSON;

  /// Indicates whether code for generating copy methods should be generated or not.
  final bool copyWith;

  /// Indicates whether code for JSON deserialization should be generated or not.
  final bool fromJSON;

  /// Whether class is immutable or not.
  final bool immutable;

  /// Whether want to generate test model or not.
  final bool test;
}

/// A constant instance of [Model] to be used as an annotation.
/// Use this constant as an annotation on classes to specify
/// wether its part of code generation or not.
///
/// ```dart
/// @model
/// class MyClass extends DModel {}
///
/// // or you can annotate it like this
///
/// @Model(immutable: false, copyWith: false)
/// class MyClass extends DModel {}
/// ```
const Model model = Model();
