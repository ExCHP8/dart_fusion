part of '../dart_fusion.dart';

/// Annotates a variable or field with additional documentation.
///
/// Use this annotation to provide documentation for variables or fields within
/// your Dart code.
///
/// Example:
/// ```dart
/// @Variable(doc: 'This variable stores the user name.')
/// String userName;
/// ```
class Variable {
  /// Creates a `Variable` annotation with optional documentation.
  ///
  /// The `doc` parameter can be used to provide additional documentation for
  /// the annotated variable or field.
  const Variable({
    this.doc,
    this.toJSON = false,
    this.fromJSON = false,
  });

  /// Additional documentation for the variable or field.
  final String? doc;

  /// Is variable has [toJSON] function or not.
  final bool toJSON;

  /// Is variable has [fromJSON] function or not.
  final bool fromJSON;
}

/// Annotates a class with options for code generation.
///
/// Use this annotation to specify code generation options for a class. It is
/// typically used to indicate whether code for JSON serialization,
/// deserialization, and copying should be generated.
///
/// Example:
/// ```dart
/// @Model(
///   toJSON: true,
///   copyWith: false,
///   fromJSON: true,
///   doc: 'This class represents a data model for user information.'
/// )
/// class UserInfo {
///   // Class implementation...
/// }
/// ```
class Model {
  /// Creates a `Model` annotation with optional options and documentation.
  ///
  /// The `toJSON`, `copyWith`, `fromJSON`, and `doc` parameters allow you to
  /// specify code generation options and provide additional documentation for
  /// the annotated class.
  const Model({
    this.immutable = true,
    this.toJSON = true,
    this.copyWith = true,
    this.fromJSON = true,
    this.doc,
  });

  /// Indicates whether code for JSON serialization should be generated.
  final bool toJSON;

  /// Indicates whether code for generating copy methods should be generated.
  final bool copyWith;

  /// Indicates whether code for JSON deserialization should be generated.
  final bool fromJSON;

  /// Additional documentation for the annotated class.
  final String? doc;

  /// Wether class is immutable or not.
  final bool immutable;
}

/// An instance of [Variable] to be used as an annotation.
///
/// Use this constant as an annotation on variables or fields to provide
/// additional documentation.
const Variable variable = Variable();

/// An instance of [Model] to be used as an annotation.
///
/// Use this constant as an annotation on classes to specify code generation
/// options.
const Model model = Model();
