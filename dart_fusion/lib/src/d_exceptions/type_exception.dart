part of '../../dart_fusion.dart';

/// An exception caused by failing to parse [Type].
class TypeException implements Exception {
  /// [TypeException] showing message on why it throws exception.
  const TypeException({required this.message});

  /// Exception [message].
  final String message;

  @override
  String toString() {
    return 'TypeException($message)';
  }
}
