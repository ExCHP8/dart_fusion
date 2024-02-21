part of '../dart_fusion.dart';

/// A utility class for parsing mostly related to http request.
final class DParse {
  /// Parsing message of http method value like `DELETE`, `GET`, `HEAD`, `OPTIONS`, `PATCH`, `POST` or `PUT`.
  ///
  /// ```dart
  /// HttpMethod method = HttpMethod.get;
  /// final message = DParse.httpMethodMessage(method.name);
  /// print(message); // 'Data successfully loaded'
  /// ```
  static String httpMethodMessage(String value) {
    switch (value.toUpperCase()) {
      case 'DELETE':
        return 'Data successfully deleted';
      case 'GET':
        return 'Data successfully loaded';
      case 'HEAD':
        return 'Headers successfully obtained';
      case 'OPTIONS':
        return 'Server options successfully retrieved';
      case 'PATCH':
        return 'Data successfully patched';
      case 'POST':
        return 'Data successfully created';
      case 'PUT':
        return 'Data successfully updated';
      default:
        return 'Method unidentified, use `DELETE`, `GET`, `HEAD`, `OPTIONS`, `PATCH`, `POST` or `PUT` instead.';
    }
  }

  /// Parsing message of [statusCode] value, usually used when catching
  /// unsuitable response value.
  ///
  /// ```dart
  /// Response response = Response(...);
  /// final message = DParse.httpStatusMessage(response.statusCode);
  /// print(message); // 'Not Found: The requested resource could not be found'
  /// ```
  static String httpStatusMessage(int statusCode) {
    switch (statusCode) {
      case 100:
        return 'Continue: The server has received the request headers and the '
            'client should proceed to send the request body';
      case 101:
        return 'Switching Protocols: The requester has asked the server to '
            'switch protocols';
      case 200:
        return 'OK: The request was successful';
      case 201:
        return 'Created: The request was successfully fulfilled and a new '
            'resource was created';
      case 202:
        return 'Accepted: The request has been accepted for processing, but the'
            ' processing has not been completed';
      case 203:
        return 'Non-Authoritative Information: The server successfully '
            'processed the request, but is returning information that may be '
            'from another source';
      case 204:
        return 'No Content: The server successfully processed the request and '
            'is not returning any content';
      case 205:
        return 'Reset Content: The server successfully processed the request, '
            'but is not returning any content and requires that the requester '
            'reset the document view';
      case 206:
        return 'Partial Content: The server is delivering only part of the '
            'resource due to a range header sent by the client';
      case 300:
        return 'Multiple Choices: Indicates multiple options for the resource '
            'that the client may follow';
      case 301:
        return 'Moved Permanently: The resource has been permanently moved to a'
            ' new location';
      case 302:
        return 'Found: The resource has been temporarily moved to a different '
            'location';
      case 303:
        return 'See Other: The response to the request can be found under a '
            'different URI';
      case 304:
        return 'Not Modified: Indicates that the resource has not been modified'
            ' since the version specified by the request headers';
      case 307:
        return 'Temporary Redirect: The resource has been temporarily moved to '
            'another location';
      case 400:
        return 'Bad Request: The server cannot process the request due to a '
            'client error';
      case 401:
        return 'Unauthorized: Authentication is required and has failed or has '
            'not been provided';
      case 403:
        return 'Forbidden: The client does not have permission to access the '
            'requested resource';
      case 404:
        return 'Not Found: The requested resource could not be found';
      case 405:
        return 'Method Not Allowed: The requested method is not allowed for '
            'this resource';
      case 406:
        return 'Not Acceptable: The requested resource is capable of generating'
            ' only content not acceptable according to the Accept headers sent '
            'in the request';
      case 407:
        return 'Proxy Authentication Required: The client must first '
            'authenticate itself with the proxy';
      case 408:
        return 'Request Timeout: The server timed out waiting for the request';
      case 409:
        return 'Conflict: Indicates that the request could not be processed '
            'because of a conflict in the current state of the resource';
      case 410:
        return 'Gone: Indicates that the requested resource is no longer '
            'available';
      case 411:
        return 'Length Required: The request did not specify the length of its '
            'content';
      case 412:
        return 'Precondition Failed: The server does not meet one of the '
            'preconditions specified by the client';
      case 413:
        return 'Payload Too Large: The request is larger than the server is '
            'willing or able to process';
      case 414:
        return 'URI Too Long: The URI provided was too long for the server to '
            'process';
      case 415:
        return 'Unsupported Media Type: The server does not support the media '
            'type requested by the client';
      case 416:
        return 'Range Not Satisfiable: The requested range cannot be fulfilled';
      case 417:
        return 'Expectation Failed: The server cannot meet the requirements of '
            'the Expect request-header field';
      case 500:
        return 'Internal Server Error: The server encountered an unexpected '
            'condition';
      case 501:
        return 'Not Implemented: The server does not support the functionality '
            'required to fulfill the request';
      case 502:
        return 'Bad Gateway: The server, while acting as a gateway or proxy, '
            'received an invalid response from an inbound server';
      case 503:
        return 'Service Unavailable: The server is currently unable to handle '
            'the request due to a temporary overload or maintenance of the '
            'server';
      case 504:
        return 'Gateway Timeout: The server, while acting as a gateway or '
            'proxy, did not receive a timely response from an upstream server';
      case 505:
        return 'HTTP Version Not Supported: The server does not support the '
            'HTTP protocol version used in the request';
      default:
        return 'Unknown Status Code: The server returned an unrecognized status'
            ' code';
    }
  }

  /// Parsing message error of [Exception].
  ///
  ///  ```dart
  /// FormatException exception = FormatException('Unexpected end of input (at character 1)');
  /// final message = DParse.exceptionMessage(exception);
  /// print(message); // 'Data is not exist'
  /// ```
  static String exceptionMessage(dynamic value) {
    switch (value.toString()) {
      case 'FormatException: Unexpected end of input (at character 1)\n\n^\n':
        return 'Data is not exist';
      case 'Null check operator used on a null value':
        return 'Data is not exist';
      case 'Bad state: No element':
        return 'Data is not exist';
      default:
        return value.toString();
    }
  }

  static T to<T extends dynamic>(dynamic value, [T? onError]) {
    try {
      if ('$T' == 'int') {
        return toInt(value, onError as int?) as T;
      } else if ('$T' == 'double') {
        return toDouble(value, onError as double?) as T;
      } else if ('$T' == 'bool') {
        return toBool(value, onError as bool?) as T;
      } else if ('$T' == 'DateTime') {
        return toDate(value, onError as DateTime?) as T;
      } else if ('$T' == 'String') {
        return toText(value, onError as String?) as T;
      } else if ('$T'.startsWith('Map') && !'$T'.endsWith('?')) {
        return toMap(value, onError as Map?) as T;
      } else if ('$T'.startsWith('List') && !'$T'.endsWith('?')) {
        return toList(value, onError as List?) as T;
      } else if ('$T' == 'int?') {
        return (mayToInt(value ?? onError)) as T;
      } else if ('$T' == 'double?') {
        return (mayToDouble(value) ?? onError) as T;
      } else if ('$T' == 'bool?') {
        return (mayToBool(value) ?? onError) as T;
      } else if ('$T' == 'DateTime?') {
        return (mayToDate(value) ?? onError) as T;
      } else if ('$T' == 'String?') {
        return (mayToText(value) ?? onError) as T;
      } else if ('$T'.startsWith('Map') && '$T'.endsWith('?')) {
        return (mayToMap(value) ?? onError) as T;
      } else if ('$T'.startsWith('List') && '$T'.endsWith('?')) {
        return (mayToList(value) ?? onError) as T;
      } else {
        if (value is T) return value;
        return onError as T;
      }
    } catch (e, s) {
      DLog({'error': e, 'stacktrace': s}.toString(), level: DLevel.error);
      return onError as T;
    }
  }

  static int toInt(dynamic value, [int? onError]) {
    return mayToInt(value) ?? onError ?? 0;
  }

  static double toDouble(dynamic value, [double? onError]) {
    return mayToDouble(value) ?? onError ?? 0.0;
  }

  static bool toBool(dynamic value, [bool? onError]) {
    return mayToBool(value) ?? onError ?? false;
  }

  static DateTime toDate(dynamic value, [DateTime? onError]) {
    return mayToDate(value) ?? onError ?? DateTime.now();
  }

  static String toText(dynamic value, [String? onError]) {
    return mayToText(value) ?? onError ?? '';
  }

  static List<U> toList<U extends dynamic>(dynamic value, [List<U>? onError]) {
    return mayToList<U>(value) ?? onError ?? <U>[];
  }

  static Map<U, V> toMap<U extends dynamic, V extends dynamic>(
    dynamic value, [
    Map<U, V>? onError,
  ]) {
    return mayToMap<U, V>(value) ?? onError ?? <U, V>{};
  }

  static int? mayToInt(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '');
  }

  static double? mayToDouble(dynamic value) {
    if (value is double) return value;
    return double.tryParse(value?.toString() ?? '');
  }

  static bool? mayToBool(dynamic value) {
    if (value is bool) return value;
    return bool.tryParse(value?.toString() ?? '');
  }

  static DateTime? mayToDate(dynamic value) {
    if (value is DateTime) return value;
    return DateTime.tryParse(value?.toString() ?? '');
  }

  static String? mayToText(dynamic value) {
    if (value is String) return value;
    return value?.toString();
  }

  static Map<U, V>? mayToMap<U extends dynamic, V extends dynamic>(
    dynamic value,
  ) {
    try {
      if (value != null) {
        if (value is Map<U, V>) return value;
        if (value is Map) {
          return <U, V>{
            for (var item in value.entries) to<U>(item.key): to<V>(item.value)
          };
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static List<U>? mayToList<U extends dynamic>(dynamic value) {
    try {
      if (value != null) {
        if (value is List<U>) return value;
        if (value is List) return <U>[for (var item in value) to<U>(item)];
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
