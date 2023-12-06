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
  }) : _list = [] {
    run();
  }

  /// Constructs a [ResponseAssertion] list with the provided [children].
  ///
  /// The [children] parameter specifies the list of [ResponseAssertion] instances to be included in this [ResponseAssertion] list.
  ///
  /// The [statusCode] parameter sets the HTTP status code for the response if any of the assertions in the [children] list fail.
  /// The default status code is 400 (Bad Request).
  ResponseAssertion.list({
    required List<ResponseAssertion> children,
    this.statusCode = 400,
  })  : _list = children,
        assertion = true,
        message = '';

  /// The list of [ResponseAssertion] instances included in this [ResponseAssertion].
  final List<ResponseAssertion> _list;

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
    if (_list.isNotEmpty && _list.any((e) => !e.assertion)) {
      ResponseAssertion assertion = _list.firstWhere((e) => !e.assertion);
      throw ResponseException(
        response: Response.json(
          statusCode: assertion.statusCode,
          body: ResponseModel(
            message: assertion.message,
          ).toJSON,
        ),
      );
    } else {
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
}
