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
  T of<T extends dynamic>(String key, [T? onError]) {
    int toInt(dynamic value) {
      return int.tryParse(value?.toString() ?? '') ??
          int.tryParse(onError?.toString() ?? '') ??
          0;
    }

    double toDouble(dynamic value) {
      return double.tryParse(value?.toString() ?? '') ??
          double.tryParse(onError?.toString() ?? '') ??
          0.0;
    }

    bool toBool(dynamic value) {
      return bool.tryParse(value?.toString() ?? '') ??
          bool.tryParse(onError?.toString() ?? '') ??
          false;
    }

    DateTime toDate(dynamic value) {
      return DateTime.tryParse(value?.toString() ?? '') ??
          DateTime.tryParse(onError?.toString() ?? '') ??
          DateTime.now();
    }

    String toText(dynamic value) {
      return value?.toString() ?? onError?.toString() ?? '';
    }

    int? toTryInt(dynamic value) {
      return int.tryParse(value!);
    }

    double? toTryDouble(dynamic value) {
      return double.tryParse(value!);
    }

    bool? toTryBool(dynamic value) {
      return bool.tryParse(value!);
    }

    DateTime? toTryDate(dynamic value) {
      return DateTime.tryParse(value!);
    }

    String? toTryText(dynamic value) {
      return value?.toString();
    }

    if (T is int) {
      return toInt(this[key]) as T;
    } else if (T is double) {
      return toDouble(this[key]) as T;
    } else if (T is bool) {
      return toBool(this[key]) as T;
    } else if (T is DateTime) {
      return toDate(this[key]) as T;
    } else if (T is String) {
      return toText(this[key]) as T;
    } else if (T is int?) {
      return toTryInt(this[key]) ?? onError as T;
    } else if (T is double?) {
      return toTryDouble(this[key]) ?? onError as T;
    } else if (T is bool?) {
      return toTryBool(this[key]) ?? onError as T;
    } else if (T is DateTime?) {
      return toTryDate(this[key]) ?? onError as T;
    } else if (T is String?) {
      return toTryText(this[key]) ?? onError as T;
    } else if (T is Map<String, int>) {
      return <String, int>{
        for (var item in (this[key] as Map).entries)
          item.key: toInt(item.value),
      } as T;
    } else if (T is Map<String, double>) {
      return <String, double>{
        for (var item in (this[key] as Map).entries)
          item.key: toDouble(item.value),
      } as T;
    } else if (T is Map<String, bool>) {
      return <String, bool>{
        for (var item in (this[key] as Map).entries)
          item.key: toBool(item.value),
      } as T;
    } else if (T is Map<String, DateTime>) {
      return <String, DateTime>{
        for (var item in (this[key] as Map).entries)
          item.key: toDate(item.value),
      } as T;
    } else if (T is Map<String, String>) {
      return <String, String>{
        for (var item in (this[key] as Map).entries)
          item.key: toText(item.value),
      } as T;
    } else if (T is Map<String, List>) {
      return <String, List>{
        for (var item in (this[key] as Map).entries)
          item.key: item.value as List,
      } as T;
    } else if (T is Map<String, JSON>) {
      return <String, JSON>{
        for (var item in (this[key] as Map).entries)
          item.key: item.value as JSON,
      } as T;
    } else if (T is Map<String, int?>) {
      return <String, int?>{
        for (var item in (this[key] as Map).entries)
          item.key: toTryInt(item.value),
      } as T;
    } else if (T is Map<String, double?>) {
      return <String, double?>{
        for (var item in (this[key] as Map).entries)
          item.key: toTryDouble(item.value),
      } as T;
    } else if (T is Map<String, bool?>) {
      return <String, bool?>{
        for (var item in (this[key] as Map).entries)
          item.key: toTryBool(item.value),
      } as T;
    } else if (T is Map<String, DateTime?>) {
      return <String, DateTime?>{
        for (var item in (this[key] as Map).entries)
          item.key: toTryDate(item.value),
      } as T;
    } else if (T is Map<String, String?>) {
      return <String, String?>{
        for (var item in (this[key] as Map).entries)
          item.key: toTryText(item.value),
      } as T;
    } else if (T is Map<String, List?>) {
      return <String, List?>{
        for (var item in (this[key] as Map).entries)
          item.key: item.value as List?,
      } as T;
    } else if (T is Map<String, JSON?>) {
      return <String, JSON?>{
        for (var item in (this[key] as Map).entries)
          item.key: item.value as JSON?,
      } as T;
    } else if (T is Map<String, dynamic>) {
      return <String, dynamic>{
        for (var item in (this[key] as Map).entries) item.key: item.value,
      } as T;
    } else if (T is List<int>) {
      return <int>[
        for (var item in this[key]) toInt(item),
      ] as T;
    } else if (T is List<double>) {
      return <double>[
        for (var item in this[key]) toDouble(item),
      ] as T;
    } else if (T is List<bool>) {
      return <bool>[
        for (var item in this[key]) toBool(item),
      ] as T;
    } else if (T is List<DateTime>) {
      return <DateTime>[
        for (var item in this[key]) toDate(item),
      ] as T;
    } else if (T is List<String>) {
      return <String>[
        for (var item in this[key]) toText(item),
      ] as T;
    } else if (T is List<List>) {
      return <List>[
        for (var item in this[key]) item as List,
      ] as T;
    } else if (T is List<JSON>) {
      return <JSON>[
        for (var item in this[key]) item as JSON,
      ] as T;
    } else if (T is List<int?>) {
      return [
        for (var item in this[key]) toTryInt(item),
      ] as T;
    } else if (T is List<double?>) {
      return [
        for (var item in this[key]) toTryDouble(item),
      ] as T;
    } else if (T is List<bool?>) {
      return [
        for (var item in this[key]) toTryBool(item),
      ] as T;
    } else if (T is List<DateTime?>) {
      return [
        for (var item in this[key]) toTryDate(item),
      ] as T;
    } else if (T is List<String?>) {
      return [
        for (var item in this[key]) toTryText(item),
      ] as T;
    } else if (T is List<List?>) {
      return [
        for (var item in this[key]) item as List?,
      ] as T;
    } else if (T is List<JSON?>) {
      return [
        for (var item in this[key]) item as JSON?,
      ] as T;
    } else if (T is List<dynamic>) {
      return <dynamic>[
        for (var item in (this[key])) item,
      ] as T;
    } else {
      try {
        return (this[key] as T? ?? onError) as T;
      } catch (e, s) {
        DLog('error: $e, stacktrace: $s', level: DLevel.error);
        throw TypeException(
            message:
                '${this[key]?.runtimeType} Doesn\'t have built in default value,'
                ' you should provide onError value manually!');
      }
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
