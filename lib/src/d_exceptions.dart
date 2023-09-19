part of '../dart_fusion.dart';

/// An exception of [Response] to be thrown.
class ResponseException implements Exception {
  /// [ResponseException] passing [Response] data to be safely thrown.
  const ResponseException({required this.response});

  /// [response] data to display what cause the exception.
  final Response response;
}

/// An exception of failed to parse [Type].
class TypeException implements Exception {
  /// [TypeException] showing message on why it throws exception.
  const TypeException({required this.message});

  /// Exception [message].
  final String message;
}
