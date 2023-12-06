part of '../dart_fusion.dart';

/// A utility class for performing response assertions.
///
/// The [ResponseAssertion] class facilitates validating assertions based on
/// boolean conditions. If the assertion fails, it throws a [ResponseException]
/// with a response message and status code.
class ResponseAssertion {
  /// Constructs a [ResponseAssertion] with the provided parameters.
  ///
  /// The [assertion] parameter represents the boolean condition to check.
  ///
  /// The [message] parameter specifies the message to be included in the response
  /// if the assertion fails.
  ///
  /// The [statusCode] parameter sets the HTTP status code for the response in case
  /// the assertion fails. The default status code is 400 (Bad Request).
  ResponseAssertion(
    // ignore: avoid_positional_boolean_parameters
    this.assertion,
    this.message, {
    this.statusCode = 400,
  }) {
    run();
  }

  /// The boolean assertion condition to be checked.
  final bool assertion;

  /// The message included in the response if the assertion fails.
  final String message;

  /// The HTTP status code for the response if the assertion fails.
  final int statusCode;

  /// Executes the assertion check.
  ///
  /// If the [assertion] fails, it throws a [ResponseException] with a response
  /// containing the specified [statusCode] and [message].
  void run() {
    if (!assertion) {
      throw ResponseException(
        response: Response.json(
          statusCode: statusCode,
          body: ResponseModel(
            message: message,
          ).toJSON,
        ),
      );
    }
  }
}
