part of '../../dart_fusion.dart';

/// Extension on the Map<String, dynamic> value.
extension JSONExtension on JSON {
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
    if (T is int) {
      return (int.tryParse(this[key]?.toString() ?? '') ?? onError ?? 0) as T;
    } else if (T is double) {
      return (double.tryParse(this[key]?.toString() ?? '') ?? onError ?? 0.0)
          as T;
    } else if (T is bool) {
      return (bool.tryParse(this[key]?.toString() ?? '') ?? onError ?? false)
          as T;
    } else if (T is JSON) {
      try {
        return <JSON>{...this[key]!} as T;
      } catch (e) {
        return (onError ?? <JSON>{}) as T;
      }
    } else if (T is List) {
      try {
        return [...this[key]!] as T;
      } catch (e) {
        return (onError ?? const []) as T;
      }
    } else if (T is DateTime) {
      return (DateTime.tryParse(this[key]?.toString() ?? '') ??
          onError ??
          DateTime.now()) as T;
    } else if (T is String) {
      return (this[key]?.toString() ?? onError ?? '') as T;
    } else {
      return (this[key] as T? ?? onError) as T;
    }
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
    if (T is int) {
      return int.tryParse(this[key]!.toString()) as T?;
    } else if (T is double) {
      return double.tryParse(this[key]!.toString()) as T?;
    } else if (T is bool) {
      return bool.tryParse(this[key]!.toString()) as T?;
    } else if (T is JSON) {
      try {
        return <JSON>{...this[key]!} as T;
      } catch (e) {
        return null;
      }
    } else if (T is List) {
      try {
        return [...this[key]!] as T;
      } catch (e) {
        return null;
      }
    } else if (T is DateTime) {
      return DateTime.tryParse(this[key]!.toString()) as T?;
    } else if (T is String) {
      return this[key]?.toString() as T?;
    } else {
      return this[key] as T?;
    }
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
