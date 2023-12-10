part of '../../dart_fusion.dart';

/// An exception of failed to parse [Type].
class TypeException implements Exception {
  /// [TypeException] showing message on why it throws exception.
  const TypeException({required this.message});

  /// Exception [message].
  final String message;
}
