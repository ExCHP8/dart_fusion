part of '../dart_fusion.dart';

/// A utility class for performing assertions and validations.
///
/// The [Assert] class facilitates assertion checks based on boolean conditions.
/// If the assertion fails, it throws an [Exception] with a provided message.
class Assert extends DModel {
  /// Constructs an [Assert] with the provided [assertion] and [message].
  ///
  /// The [assertion] parameter represents the boolean condition to check.
  ///
  /// The [message] parameter specifies the message to be included in the exception
  /// if the assertion fails.
  Assert(this.assertion, this.message) : children = [] {
    _run();
  }

  /// Constructs an [Assert] instance with a list of child [Assert] instances.
  ///
  /// The [children] parameter specifies a list of [Assert] instances to be executed.
  ///
  /// The [assertion] property is set to `true` by default.
  ///
  /// The [message] property is an empty string by default.
  Assert.list({
    required this.children,
  })  : assertion = true,
        message = '' {
    _run();
  }

  /// The list of child [Assert] instances to be executed.
  final List<Assert> children;

  /// The boolean assertion condition to be checked.
  final bool assertion;

  /// The message included in the exception if the assertion fails.
  final String message;

  /// Runs the assertion check.
  void _run() {
    if (!assertion && children.isEmpty) {
      throw Exception(message);
    }
  }

  ///
  /// The [assertion] parameter represents the boolean condition to check.
  ///
  /// The [message] parameter specifies the message to be included in the exception
  /// if the assertion fails.
  ///
  /// The [statusCode] parameter sets the HTTP status code for the response
  /// if the assertion fails. The default status code is 400 (Bad Request).
  static ResponseAssert response(
    bool assertion,
    String message, {
    int statusCode = 400,
  }) {
    return ResponseAssert(
      assertion,
      message,
      statusCode: statusCode,
    );
  }

  static Assert fromJSON(JSON value) {
    return Assert(
      value.of('assertion', true),
      value.of('message'),
    );
  }

  @override
  Assert copyWith({
    bool? assertion,
    String? message,
  }) {
    return Assert(
      assertion ?? this.assertion,
      message ?? this.message,
    );
  }

  @override
  JSON get toJSON => {
        'assertion': assertion,
        'message': message,
        ...super.toJSON,
      };
}

/// A specialized [Assert] class for handling response-related assertions.
///
/// The [ResponseAssert] class extends [Assert] and introduces functionality
/// to handle assertions related to HTTP responses, including status code checks.
class ResponseAssert extends Assert {
  /// Constructs a [ResponseAssert] with the provided [assertion], [message], and [statusCode].
  ///
  /// The [statusCode] parameter sets the HTTP status code for the response
  /// if the assertion fails. The default status code is 400 (Bad Request).
  ResponseAssert(bool assertion, String message, {this.statusCode = 400})
      : super(assertion, message) {
    _run();
  }

  /// The HTTP status code for the response if the assertion fails.
  final int statusCode;

  @override
  void _run() {
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

  @override
  JSON get toJSON => {
        'status_code': statusCode,
        ...super.toJSON,
      };

  static ResponseAssert fromJSON(JSON value) {
    return ResponseAssert(
      value.of('assertion', true),
      value.of('message'),
      statusCode: value.of('status_code'),
    );
  }

  @override
  ResponseAssert copyWith({
    bool? assertion,
    String? message,
    int? statusCode,
  }) {
    return ResponseAssert(
      assertion ?? this.assertion,
      message ?? this.message,
      statusCode: statusCode ?? this.statusCode,
    );
  }
}
