part of '../../dart_fusion.dart';

/// A well-design middleware used in dart backend.
class DMiddleware extends DModel {
  /// Default constructor of [DMiddleware].
  const DMiddleware({this.certificate});

  /// A function to validate jwt certificate
  final String Function(String key)? certificate;

  /// Middleware for handling requests and responses.
  ///
  /// This middleware supports both regular HTTP requests and websockets.
  ///
  /// [handler] is the main request handler.
  /// [certificate] is an optional function for certificate verification.
  Handler handler({required Handler handler}) {
    return (context) async {
      final response = await handler(context);
      try {
        // [2] Return Websocket
        if (context.isWebSocket) {
          return response;
        } else {
          // [3] Verify Bearer Token
          if (certificate != null) await context.verify(certificate!);

          // [4] Return successful response
          if (response.statusCode >= 200 && response.statusCode < 300) {
            final json = await response.json() as JSON? ?? {};
            return Response.json(
              headers: response.headers,
              body: json['model_type'] == 'ResponseModel'
                  ? json
                  : ResponseModel(
                      message: DParse.httpMethodMessage(context.method.value),
                      data: json,
                      success: true,
                    ).toJSON,
            );
          } else {
            // [5] Return failed response
            final body = await response.body();
            bool isHavingMessage() {
              try {
                return (jsonDecode(body) as JSON).isNotEmpty;
              } catch (e) {
                return body.isNotEmpty;
              }
            }

            throw ResponseException(
              response: Response.json(
                headers: response.headers,
                statusCode: response.statusCode,
                body: ResponseModel(
                  message: DParse.httpStatusMessage(response.statusCode) +
                      (isHavingMessage() ? '\n\n --- \n\n$body' : body),
                ).toJSON,
              ),
            );
          }
        }
      } on ResponseException catch (e) {
        return e.response;
      } catch (e) {
        // [6] Return uncaught event
        return Response.json(
          headers: response.headers,
          statusCode: 400,
          body: ResponseModel(
            message: DParse.exceptionMessage('$e'),
          ).toJSON,
        );
      }
    };
  }
}
