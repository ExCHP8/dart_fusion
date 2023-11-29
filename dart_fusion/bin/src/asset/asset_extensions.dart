part of '../../dart_fusion.dart';

extension DirectoryExtension on Directory {
  String file(
      void Function(List<Directory> directories, List<File> files) value) {
    List<File> files = [];
    List<Directory> directories = [if (listSync().any((e) => e is File)) this];
    final StringBuffer classes = StringBuffer();
    final StringBuffer variables = StringBuffer();

    for (var item in listSync(recursive: true)) {
      if (item is Directory) {
        if (item.listSync().any((e) => e is File)) {
          directories.add(item);
        }
      } else if (item is File) {
        files.add(item);
      }
    }

    directories.toPubspec();

    for (var dir in directories) {
      variables
        ..clear()
        ..write('\n');
      for (var fil in dir.listSync()) {
        bool isRoot = fil.parent.path == path;
        if (fil is File) {
          final ext = fil.path.split('.').last.toLowerCase();
          variables.write('''

  /// Asset derived from `${fil.path}`, with ${fil.statSync().size.toBytes} size.
  /// ${(ext == 'png' || ext == 'jpg' || ext == 'svg' || ext == 'jpeg' || ext == 'bmp' || ext == 'gif' || ext == 'tiff' || ext == 'webp') ? '\n\t/// <img src="${fil.absolute.path}" alt="${fil.name}" width="30" height="30" />\n\t///' : ''}
  /// ```dart
  /// String value = ${dir.name}${isRoot ? '' : '()'}.${fil.name};
  /// ```
  ${isRoot ? "static const String ${fil.name} = '${fil.path}'" : "String get ${fil.name} => '${fil.path}'"};
''');
        } else if (fil is Directory) {
          variables.write('''

  /// Asset derived from `${fil.path}, containing ${fil.listSync().length} items.`
  /// 
  /// ```dart
  /// ${fil.name} value = ${dir.name}${isRoot ? '' : '()'}.${fil.originalName};
  /// ```
  ${isRoot ? 'static const ${fil.name} ${fil.originalName} = ${fil.name}();' : '${fil.name} get ${fil.originalName} => const ${fil.name}();'}
''');
        }
      }

      classes.write('''
/// An asset class scanned from `${dir.path}`, containing ${dir.listSync().whereType<File>().length} files.
/// 
/// ```dart
/// String value = ${dir.name}.value;
/// ```
class ${dir.name} {
  /// Default constant constructor of directory
  const ${dir.name}();

  /// Path of this class directory
  ${dir == this ? "static const String path = '${dir.path}';" : "String get path => '${dir.path}';"}$variables
}

''');
    }

    value(directories, files);

    return '''
// Dart Fusion Auto-Generated Asset Scanner
// Created at ${DateTime.now()}
// 🍔 [Buy me a coffee](https://www.buymeacoffee.com/nialixus) 🚀
// ignore_for_file: constant_identifier_names, non_constant_identifier_names

$classes
''';
  }

  String get name {
    if (path.contains("/")) {
      return path.split("/").reversed.map((e) => e.capitalize).join("");
    } else {
      return path.capitalize;
    }
  }

  String get originalName {
    if (path.contains("/")) {
      return path.split("/").last.toLowerCase();
    } else {
      return path.toLowerCase();
    }
  }
}

extension FileExtension on File {
  String get name {
    String result = path
        .split("/")
        .last
        .split(".")
        .first
        .split(RegExp(r'\W+'))
        .asMap()
        .entries
        .map((e) => e.key == 0 ? e.value.toLowerCase() : e.value.capitalize)
        .join();

    if (result.trim().isEmpty) {
      return path.split('/').last.replaceAll('.', '');
    } else {
      switch (result.trim()) {
        case 'is':
        case 'do':
        case 'while':
        case 'break':
        case 'continue':
        case 'return':
        case 'case':
        case 'default':
        case 'if':
        case 'else':
        case 'for':
        case 'switch':
        case 'assert':
        case 'try':
        case 'catch':
        case 'finally':
        case 'rethrow':
        case 'throw':
        case 'on':
        case 'typedef':
        case 'async':
        case 'await':
        case 'yield':
        case 'yield*':
        case 'sync':
        case 'external':
        case 'covariant':
        case 'deferred':
        case 'get':
        case 'hide':
        case 'implements':
        case 'import':
        case 'library':
        case 'operator':
        case 'part':
        case 'set':
        case 'show':
        case 'source':
        case 'static':
        case 'with':
        case 'path':
        case 'instance':
        case 'new':
          return '${result}_';
        default:
          return result;
      }
    }
  }
}

extension IntExtension on int {
  String get toBytes {
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

extension StringExtension on String {
  String short(int length) {
    return substring(0, this.length < length ? this.length : length);
  }

  String get name {
    switch (trim()) {
      case 'is':
      case 'do':
      case 'while':
      case 'break':
      case 'continue':
      case 'return':
      case 'case':
      case 'default':
      case 'if':
      case 'else':
      case 'for':
      case 'switch':
      case 'assert':
      case 'try':
      case 'catch':
      case 'finally':
      case 'rethrow':
      case 'throw':
      case 'on':
      case 'typedef':
      case 'async':
      case 'await':
      case 'yield':
      case 'yield*':
      case 'sync':
      case 'external':
      case 'covariant':
      case 'deferred':
      case 'get':
      case 'hide':
      case 'implements':
      case 'import':
      case 'library':
      case 'operator':
      case 'part':
      case 'set':
      case 'show':
      case 'source':
      case 'static':
      case 'with':
      case 'path':
      case 'instance':
      case 'new':
        return '${this}_';
      default:
        return this;
    }
  }

  String get capitalize {
    try {
      return this[0].toUpperCase() + substring(1).toLowerCase();
    } catch (e) {
      return toUpperCase();
    }
  }

  String get directory {
    if (endsWith("/")) {
      return this;
    } else {
      List<String> split = this.split("/");
      if (split.last.contains('.')) split.removeLast();
      return split.join("/");
    }
  }
}

extension DirectoryListExtension on List<Directory> {
  void toPubspec() {
    File pubspec = File('pubspec.yaml');
    List<String> lines = pubspec.readAsLinesSync();
    int flutterIndex =
        lines.lastIndexWhere((line) => line.trim() == 'flutter:');
    int assetsIndex = lines.lastIndexWhere((line) => line.trim() == 'assets:');
    if (flutterIndex == -1) {
      lines.insert(lines.length - 1, 'flutter:\n  assets:');
    } else {
      if (assetsIndex == -1) {
        lines.insert(flutterIndex + 1, '  assets:');
      }
    }

    for (var directory in this) {
      int assetsIndex =
          lines.lastIndexWhere((line) => line.trim() == 'assets:');
      int directoryIndex =
          lines.lastIndexWhere((line) => line.trim() == '- ${directory.path}/');
      if (directoryIndex == -1) {
        lines.insert(assetsIndex + 1, '    - ${directory.path}/');
      }
    }

    pubspec.writeAsStringSync(lines.join('\n'));
  }
}
