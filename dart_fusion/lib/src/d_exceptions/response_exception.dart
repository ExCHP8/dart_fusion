part of '../../dart_fusion.dart';

/// An exception containing [Response] value.
class ResponseException implements Exception {
  /// [ResponseException] passing [Response] data to be safely thrown.
  const ResponseException({required this.response});

  /// [response] data to display what cause the exception.
  final Response response;
}
