part of '../../dart_fusion.dart';

/// Configuration class for defining Cross-Origin Resource Sharing (CORS) policies.
///
/// Use the [Cors] class to specify CORS policy settings for handling cross-origin requests in a Dart backend application.
class Cors extends DModel {
  /// Constructs a [Cors] instance with specified CORS policy settings.
  ///
  /// By default, allows requests from any origin ('*'), doesn't specify allowed methods or headers,
  /// allows credentials, doesn't expose additional headers, and sets a maximum age of 24 hours.
  const Cors({
    this.ACCESS_CONTROL_ALLOW_ORIGIN = const ['*'],
    this.ACCESS_CONTROL_ALLOW_METHODS = const [],
    this.ACCESS_CONTROL_ALLOW_HEADERS = const [Header.contentType],
    this.ACCESS_CONTROL_ALLOW_CREDENTIALS = false,
    this.ACCESS_CONTROL_EXPOSE_HEADERS = const [],
    this.ACCESS_CONTROL_MAX_AGE = const Duration(hours: 24),
  });

  /// List of allowed origins for CORS requests.
  final List<String> ACCESS_CONTROL_ALLOW_ORIGIN;

  /// List of allowed HTTP methods for CORS requests.
  final List<HttpMethod> ACCESS_CONTROL_ALLOW_METHODS;

  /// List of allowed headers for CORS requests.
  final List<Header> ACCESS_CONTROL_ALLOW_HEADERS;

  /// Indicates whether credentials (such as cookies or HTTP authentication) are allowed for CORS requests.
  final bool ACCESS_CONTROL_ALLOW_CREDENTIALS;

  /// List of headers exposed to the browser in CORS responses.
  final List<Header> ACCESS_CONTROL_EXPOSE_HEADERS;

  /// Maximum duration (in seconds) that the CORS preflight response should be cached.
  final Duration ACCESS_CONTROL_MAX_AGE;

  @override
  Cors copyWith({
    List<String>? ACCESS_CONTROL_ALLOW_ORIGIN,
    List<HttpMethod>? ACCESS_CONTROL_ALLOW_METHODS,
    List<Header>? ACCESS_CONTROL_ALLOW_HEADERS,
    bool? ACCESS_CONTROL_ALLOW_CREDENTIALS,
    List<Header>? ACCESS_CONTROL_EXPOSE_HEADERS,
    Duration? ACCESS_CONTROL_MAX_AGE,
  }) {
    return Cors(
      ACCESS_CONTROL_ALLOW_CREDENTIALS: ACCESS_CONTROL_ALLOW_CREDENTIALS ??
          this.ACCESS_CONTROL_ALLOW_CREDENTIALS,
      ACCESS_CONTROL_ALLOW_HEADERS:
          ACCESS_CONTROL_ALLOW_HEADERS ?? this.ACCESS_CONTROL_ALLOW_HEADERS,
      ACCESS_CONTROL_ALLOW_METHODS:
          ACCESS_CONTROL_ALLOW_METHODS ?? this.ACCESS_CONTROL_ALLOW_METHODS,
      ACCESS_CONTROL_ALLOW_ORIGIN:
          ACCESS_CONTROL_ALLOW_ORIGIN ?? this.ACCESS_CONTROL_ALLOW_ORIGIN,
      ACCESS_CONTROL_EXPOSE_HEADERS:
          ACCESS_CONTROL_EXPOSE_HEADERS ?? this.ACCESS_CONTROL_EXPOSE_HEADERS,
      ACCESS_CONTROL_MAX_AGE:
          ACCESS_CONTROL_MAX_AGE ?? this.ACCESS_CONTROL_MAX_AGE,
    );
  }

  static Cors fromJSON(JSON value) {
    return Cors(
      ACCESS_CONTROL_ALLOW_CREDENTIALS:
          value.of('Access-Control-Allow-Credentials'),
      ACCESS_CONTROL_ALLOW_ORIGIN:
          value.of<String>('Access-Control-Allow-Origin').split(', '),
      ACCESS_CONTROL_ALLOW_METHODS: value
          .of<String>('Access-Control-Allow-Methods')
          .split(', ')
          .map(
            (e) => HttpMethod.values.firstWhere(
              (f) => f.name.toUpperCase() == e.toUpperCase(),
              orElse: () => HttpMethod.options,
            ),
          )
          .toList(),
      ACCESS_CONTROL_MAX_AGE:
          Duration(seconds: value.of('Access-Control-Max-Age')),
      ACCESS_CONTROL_ALLOW_HEADERS: value
          .of<String>('Access-Control-Allow-Headers')
          .replaceAll('-', '')
          .split(', ')
          .map((e) => Header.fromJSON({'model_type': e}))
          .toList(),
      ACCESS_CONTROL_EXPOSE_HEADERS: value
          .of<String>('Access-Control-Expose-Headers')
          .replaceAll('-', '')
          .split(', ')
          .map((e) => Header.fromJSON({'model_type': e}))
          .toList(),
    );
  }

  @override
  JSON get toJSON {
    final acao = ACCESS_CONTROL_ALLOW_ORIGIN;
    final acam = ACCESS_CONTROL_ALLOW_METHODS;
    final acah = ACCESS_CONTROL_ALLOW_HEADERS;
    final acac = ACCESS_CONTROL_ALLOW_CREDENTIALS;
    final aceh = ACCESS_CONTROL_EXPOSE_HEADERS;
    final acma = ACCESS_CONTROL_MAX_AGE;
    String toString(HttpMethod e) => e.name.toUpperCase();
    return {
      if (acao.isNotEmpty) 'Access-Control-Allow-Origin': acao.join(', '),
      if (acam.isNotEmpty)
        'Access-Control-Allow-Methods': acam.map(toString).join(', '),
      if (acah.isNotEmpty) 'Access-Control-Allow-Headers': acah.join(', '),
      'Access-Control-Allow-Credentials': '$acac',
      if (aceh.isNotEmpty) 'Access-Control-Expose-Headers': aceh.join(', '),
      'Access-Control-Max-Age': '${acma.inSeconds}',
    };
  }

  /// Checks if the origin is allowed based on the CORS configuration.
  bool isOriginAllowed(
    RequestContext context, {
    required Cors cors,
  }) {
    final origin = context.request.headers['Origin'];
    final isAllAllowed = cors.ACCESS_CONTROL_ALLOW_ORIGIN.contains('*') ||
        cors.ACCESS_CONTROL_ALLOW_ORIGIN.isEmpty;
    final isOneAllowed = cors.ACCESS_CONTROL_ALLOW_ORIGIN.any((e) {
      if (origin != null) {
        final encode = e
            .replaceAll('.', r'\.')
            .replaceAll('/', r'\/')
            .replaceAll('*', '.*');
        return RegExp('^$encode\$').hasMatch(origin);
      } else {
        return false;
      }
    });
    return isAllAllowed || isOneAllowed;
  }

  /// Checks if the HTTP method is allowed based on the CORS configuration.
  bool isMethodAllowed(
    RequestContext context, {
    required Cors cors,
  }) {
    final isAllAllowed = cors.ACCESS_CONTROL_ALLOW_METHODS.isEmpty;
    final isOneAllowed =
        cors.ACCESS_CONTROL_ALLOW_METHODS.contains(context.request.method);
    return isAllAllowed || isOneAllowed;
  }

  /// Checks if the headers are allowed based on the CORS configuration.
  bool isHeaderAllowed(
    RequestContext context, {
    required Cors cors,
  }) {
    final headers = [
      for (final key in context.request.headers.keys)
        Header.fromJSON({'model_type': key}),
    ];
    final isAllAllowed = cors.ACCESS_CONTROL_ALLOW_HEADERS.isEmpty;
    final isOneAllowed =
        cors.ACCESS_CONTROL_ALLOW_HEADERS.any(headers.contains);
    return isAllAllowed || isOneAllowed;
  }

  /// Checks if credentials are allowed based on the CORS configuration.
  bool isCredentialAllowed(
    RequestContext context, {
    required Cors cors,
  }) {
    final isAllAlowed = !cors.ACCESS_CONTROL_ALLOW_CREDENTIALS;
    final isOneAllowed = !cors.ACCESS_CONTROL_ALLOW_ORIGIN.contains('*') &&
        cors.ACCESS_CONTROL_ALLOW_CREDENTIALS;
    return isAllAlowed || isOneAllowed;
  }

  /// Handler method to validate CORS policies and modify response headers.
  Handler handler(Handler handler) {
    return (context) async {
      var response = await handler(context);
      response = response.copyWith(
        headers: {
          ...response.headers,
          ...toJSON,
        },
      );
      final cors = Cors.fromJSON(response.headers);

      Assert.list(
        children: [
          Assert.response(
            context.request.headers['Origin'] != null,
            'Missing Origin header in the request.',
          ),
          Assert.response(
            isOriginAllowed(context, cors: cors),
            'Access denied for this origin.',
            statusCode: 403,
          ),
          Assert.response(
            isMethodAllowed(context, cors: cors),
            'Requested HTTP method is not allowed for this resource.',
            statusCode: 405,
          ),
          // Assert.response(
          //   isHeaderAllowed(context, cors: cors),
          //   'Requested headers are not allowed by the CORS policy.',
          //   statusCode: 403,
          // )
          Assert.response(
            isCredentialAllowed(context, cors: cors),
            'Conflict between Allow-Credentials and Allow-Origin.',
            statusCode: 500,
          ),
        ],
      );

      return response;
    };
  }
}
