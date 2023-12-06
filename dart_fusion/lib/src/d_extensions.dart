part of '../dart_fusion.dart';

/// Extension on numeric types (int, double) to add utility methods for limiting values within a specified range.
extension OnNumber<Number extends num> on Number {
  /// Returns the greater of this number and [min]. If this number is less than [min], [min] will be returned.
  ///
  /// ```dart
  /// int min = 5.min(10);
  /// print(min); // 10
  /// ```
  Number min(Number min) => this < min ? min : this;

  /// Returns the lesser of this number and [max]. If this number is greater than [max], [max] will be returned.
  ///
  /// ```dart
  /// double max = 100.0.max(10.0);
  /// print(max); // 10.0
  /// ```
  Number max(Number max) => this > max ? max : this;

  /// Returns this number, clamped to the range of [min] to [max].
  ///
  /// If this number is less than [min], [min] will be returned.
  /// If this number is greater than [max], [max] will be returned.
  /// Otherwise, this number will be returned unchanged.
  ///
  /// ```dart
  /// int number = 75.limit(0, 100);
  /// print(number); // 75
  /// ```
  Number limit(Number min, Number max) => this < min
      ? min
      : this > max
          ? max
          : this;
}

/// Extension on the Map<String, dynamic> value.
extension OnJSON on JSON {
  /// Merge between one [JSON] to another, usefull for values with same key in
  /// a [JSON] structure.
  ///
  /// ```dart
  /// JSON json = {"primary": "1", "secondary": "2"};
  /// JSON anotherJSON = {"primary": "10", "tertiary": "3"};
  /// print(json.merge(anotherJSON)); // {"primary": "10", "secondary": "2", "tertiary": "3"}
  /// ```
  JSON merge(JSON other) {
    final result = <String, dynamic>{};

    for (final key in keys) {
      if (other.containsKey(key) && this[key] is JSON && other[key] is JSON) {
        result[key] = (this[key] as JSON).merge(other[key] as JSON);
      } else {
        result[key] = this[key];
      }
    }

    for (final key in other.keys) {
      if (!result.containsKey(key)) {
        result[key] = other[key];
      }
    }

    return result;
  }

  /// Parse `dynamic` value to given [T] with an optional [onError] fallback.
  ///
  ///  ```dart
  /// JSON value = {"primary": "1"};
  /// String primary = value.of<String>("primary");
  /// print(primary); // "1"
  /// String secondary = value.of<String>("secondary", "No Data");
  /// print(secondary); // "No Data"
  /// ```
  T of<T extends Object>(String key, [T? onError]) {
    T onElse() {
      if (T is int) {
        return 0 as T;
      } else if (T is double) {
        return 0.0 as T;
      } else if (T is bool) {
        return false as T;
      } else if (T is String) {
        return '' as T;
      } else if (T is JSON) {
        return <JSON>{} as T;
      } else if (T is List) {
        return [] as T;
      } else if (T is DateTime) {
        return DateTime.now() as T;
      } else {
        throw const TypeException(
            message: 'Type is not provided, '
                'use <JSON>{}.maybeOf("key") instead.');
      }
    }

    return this[key] as T? ?? onError ?? onElse();
  }

  /// Parse `dynamic` value in [JSON] to given nullable [T].
  ///
  /// ```dart
  /// JSON value = {"primary": "1"};
  /// String? primary = value.maybeOf<String>("primary");
  /// print(primary); // "1"
  /// String? secondary = value.maybeOf<String>("secondary");
  /// print(secondary); // null
  /// ```
  T? maybeOf<T extends Object>(String key) {
    return this[key] as T?;
  }

  /// Parse [FormData] fields to [JSON].
  JSON get toJSON {
    var data = <String, dynamic>{};
    for (final entry in entries) {
      if (entry.key.contains('.')) {
        final prefix = entry.key.split('.').map((e) => '"$e":').join('{');
        final suffix =
            [for (int x = 0; x < entry.key.split('.').length; x++) '}'].join();
        final complete = '${'{$prefix"'}${entry.value}"$suffix';
        data = data.merge(jsonDecode(complete) as JSON? ?? {});
      } else {
        data.addAll({entry.key: entry.value});
      }
    }

    return data;
  }
}

/// Extensioning generic [List] value.
extension OnList<OldValue extends Object?> on List<OldValue> {
  /// Generate index and item of a [List].
  ///
  /// ```dart
  /// List<String> texts = ["one", "two", "three"];
  /// List<Widget> widgets = texts.to((index, item) => Text("$index: $item"));
  /// ```
  List<NewValue> to<NewValue extends Object?>(
          NewValue Function(int index, OldValue item) value) =>
      asMap()
          .entries
          .map<NewValue>((map) => value(map.key, map.value))
          .toList();

  /// A shortcut of extended sublist with safety.
  List<OldValue> limit(int start, int length) {
    final end = start + length;
    return start > this.length
        ? this
        : end > this.length
            ? sublist(start, this.length)
            : sublist(start, end);
  }
}

/// An extension of [DModel] list.
extension OnDModelList on List<DModel> {
  /// A shortcut to call [toJSON] from [DModel].
  ///
  /// ```dart
  /// List<DModel> dmodels = [DModel(), DModel()];
  /// List<JSON> jsons = dmodels.toJSON;
  /// ```
  List<JSON> get toJSON => map((e) => e.toJSON).toList();
}

/// Extension on [String] to provide additional functionality.
extension OnString on String {
  /// Replaces occurrences of keys with their respective values from the provided map.
  ///
  /// [key] is a map of string keys and their corresponding values to replace in the string.
  ///
  /// Returns a new string with replaced values.
  String add({required Map<String, String> key}) =>
      key.entries.fold(this, (output, entry) {
        return output.replaceAll(entry.key, entry.value);
      });

  /// Capitalizes the first letter of the string.
  ///
  /// Returns the string with the first letter capitalized.
  ///
  /// ```dart
  /// String word = 'magnificent'.capitalize;
  /// print(word); // Magnificent
  /// ```
  String get capitalize {
    try {
      return this[0].toUpperCase() + substring(1, length);
    } catch (e) {
      return toString().toUpperCase();
    }
  }
}

/// Extension on [int] to provide additional functionality.
extension OnInteger on int {
  /// Converts the integer to a human-readable string representing bytes, KB, MB, or GB.
  ///
  /// Returns a string representation of the size in bytes, KB, MB, or GB.
  ///
  /// ```dart
  /// int bytes = 1048576;
  /// String parse = bytes.toReadableBytes;
  /// print(parse); // "1048.57 KB"
  /// ```
  String get toReadableBytes {
    if (this < 1024) {
      return '$this B';
    } else if (this < 1024 * 1024) {
      double sizeInKB = this / 1024;
      return '${sizeInKB.toStringAsFixed(2)} KB';
    } else if (this < 1024 * 1024 * 1024) {
      double sizeInMB = this / (1024 * 1024);
      return '${sizeInMB.toStringAsFixed(2)} MB';
    } else {
      double sizeInGB = this / (1024 * 1024 * 1024);
      return '${sizeInGB.toStringAsFixed(2)} GB';
    }
  }
}

/// An extension of [RequestContext].
extension OnRequestContext on RequestContext {
  /// A shortcut to get [HttpMethod] out of [RequestContext].
  HttpMethod get method => request.method;

  /// Check whether request method is [HttpMethod.get] or not.
  bool get isGET => method == HttpMethod.get;

  /// Check whether request method is [HttpMethod.post] or not.
  bool get isPOST => method == HttpMethod.post;

  /// Check whether request method is [HttpMethod.delete] or not.
  bool get isDELETE => method == HttpMethod.delete;

  /// Check whether request method is [HttpMethod.put] or not.
  bool get isPUT => method == HttpMethod.put;

  /// Check whether request is a http request or websocket request.
  bool get isWebSocket => request.url.toString().startsWith('ws');

  /// A shortcut to get parameter from [RequestContext].
  JSON get parameter => request.uri.queryParameters;

  /// A function to verifiy `Bearer Token`.
  Future<JWT> verify(String Function(String key) certificate) async {
    try {
      final token = request.headers['authorization']!.split(' ').last;
      final key = JWT.decode(token).header!['kid'].toString();
      return JWT.verify(token, RSAPublicKey.cert(certificate(key)));
    } catch (e) {
      throw ResponseException(
        response: Response.json(
          statusCode: 401,
          body: ResponseModel(
            message: DParse.httpStatusMessage(401),
          ).toJSON,
        ),
      );
    }
  }
}
