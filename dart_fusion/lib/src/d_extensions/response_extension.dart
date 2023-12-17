part of '../../dart_fusion.dart';

/// Extension for handling assertions on HTTP responses.
extension ResponseExtension on Response {
  /// Asserts the validity of the response based on the given [assertion].
  ///
  /// Optionally, you can provide [message], [headers], and [statusCode] for
  /// detailed assertion checks.
  ResponseAssert assertion(
    bool assertion,
    String message, {
    Map<String, String>? headers,
    int? statusCode,
  }) {
    return ResponseAssert(
      assertion,
      message,
      headers: headers ?? this.headers,
      statusCode: statusCode ?? this.statusCode,
    );
  }
}
