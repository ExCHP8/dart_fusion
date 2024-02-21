part of '../../dart_fusion.dart';

/// A well-design middleware used in dart backend.
final class DMiddleware {
  /// Middleware for handling requests and responses.
  ///
  /// This middleware supports both regular HTTP requests and websockets.
  ///
  /// [handler] is the main request handler.
  Handler handler(Handler handler) {
    return (context) async {
      try {
        final response = await handler(context);

        // [2] Return Websocket
        if (context.isWebSocket) {
          return response;
        } else {
          // [3] Verify Bearer Token
          // if (certificate != null) await context.verify(certificate!);

          // [4] Return successful response
          if (response.statusCode >= 200 && response.statusCode < 300) {
            final json = (await response.json()) as JSON? ?? {};
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
            final json = (await response.json()) as JSON? ?? {};
            throw ResponseException(
              response: Response.json(
                headers: response.headers,
                statusCode: response.statusCode,
                body: json['model_type'] == 'ResponseModel'
                    ? json
                    : ResponseModel(
                        message: DParse.httpStatusMessage(response.statusCode),
                        data: json,
                      ).toJSON,
              ),
            );
          }
        }
      } on ResponseException catch (e) {
        return e.response;
      } catch (e) {
        // [6] Return uncaught event
        Response? response;

        try {
          response = await handler(context);
        } catch (e) {
          response = null;
        }

        return Response.json(
          headers: response?.headers ?? {},
          statusCode: 400,
          body: ResponseModel(
            message: DParse.exceptionMessage('$e'),
          ).toJSON,
        );
      }
    };
  }
}
