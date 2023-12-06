part of '../dart_fusion.dart';

/// A set of service collection mosty used in dart backend.
class DService {
  /// Middleware for handling requests and responses.
  ///
  /// This middleware supports both regular HTTP requests and websockets.
  ///
  /// [T] is the type of data model expected.
  ///
  /// [handler] is the main request handler.
  /// [certificate] is an optional function for certificate verification.
  /// [data] is a function to process the received JSON data.
  static Handler middleware({
    required Handler handler,
    String Function(String key)? certificate,
  }) {
    return (context) async {
      try {
        if (context.isWebSocket) {
          return handler(context);
        } else {
          if (certificate != null) await context.verify(certificate);
          final response = await handler(context);
          if (response.statusCode >= 200 && response.statusCode < 300) {
            final json = await response.json() as JSON? ?? {};
            return Response.json(
              body: json['model_type'] == 'ResponseModel'
                  ? json
                  : ResponseModel(
                      message: DParse.httpMethodMessage(context.method.value),
                      data: json,
                      success: true,
                    ).toJSON,
            );
          } else {
            final body = await response.body();
            throw ResponseException(
              response: Response.json(
                statusCode: response.statusCode,
                body: ResponseModel(
                  message: DParse.httpStatusMessage(response.statusCode) +
                      (body.isNotEmpty ? '\n\n --- \n\n$body' : body),
                ).toJSON,
              ),
            );
          }
        }
      } on ResponseException catch (e) {
        return e.response;
      } catch (e) {
        return Response.json(
          statusCode: 400,
          body: ResponseModel(
            message: DParse.exceptionMessage('$e'),
          ).toJSON,
        );
      }
    };
  }

  /// Generate simple random key identifier
  ///
  /// with [length] by default limit to `6`,
  /// and [characters] default to `ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789`
  static String randomID({
    String characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789',
    int length = 6,
  }) {
    Random random = Random();
    StringBuffer generatedValue = StringBuffer();
    for (var i = 0; i < length; i++) {
      final randomIndex = random.nextInt(characters.length);
      generatedValue.write(characters[randomIndex]);
    }

    return generatedValue.toString();
  }
}
