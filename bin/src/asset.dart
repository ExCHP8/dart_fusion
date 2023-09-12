part of '../dart_fusion.dart';

void insertAsset({required ArgResults from}) {
  try {
    if (from['help'] == true) {
      throw '\x1B[0mAvailable commands :';
    } else {
      String input = from['input']!.toString();
      String output = from['output']!.toString();

      Directory(output.directory).createSync(recursive: true);
      File(output)
        ..writeAsStringSync(input.file)
        ..createSync(recursive: true);
    }
  } catch (e) {
    print('\n\x1B[31m$e\x1B[0m\n\n'
        '+---------------+-----------------------------------------------+\n'
        '| OPTION\t| DESCRIPTION\t\t\t\t\t|\n'
        '+---------------+-----------------------------------------------+\n'
        '| -i, --input\t| Input directory of where assets took place.\t|\n'
        '| \t\t| \x1B[2mdefault to \x1B[0m\x1B[33m"assets"\x1B[0m\t\t\t\t|\n'
        '| -o, --output\t| Output file of generated asset class.\t\t|\n'
        '| \t\t| \x1B[2mdefault to \x1B[0m\x1B[33m"lib/src/assets.dart"\x1B[0m\t\t|\n'
        '| -h, --help\t| Print this usage information.\t\t\t|\n'
        '+---------------+-----------------------------------------------+\n'
        '\nUsage : '
        '\n- \x1B[32mdart\x1B[0m run \x1B[34mdart_fusion\x1B[0m asset -i \x1B[33m"assets"\x1B[0m -o \x1B[33m"lib/src/assets.dart"\x1B[0m');
  }
}

extension DirectoryExtension on Directory {
  String get name {
    if (path.contains("/")) {
      return path.split("/").reversed.map((e) => e.capitalize).join("");
    } else {
      return path.capitalize;
    }
  }
}

extension FileExtension on File {
  String get name {
    return path.split("/").last.split(".").first.toLowerCase();
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
  String get capitalize {
    try {
      return this[0].toUpperCase() + substring(1, length);
    } catch (e) {
      return toString().toUpperCase();
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

  String get file {
    List<File> files = [];
    List<Directory> directories = [if (Directory(this).listSync().any((e) => e is File)) Directory(this)];
    final StringBuffer classes = StringBuffer();
    final StringBuffer variables = StringBuffer();

    for (var item in Directory(this).listSync(recursive: true)) {
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
      for (var fil in files.where((e) => e.parent.path == dir.path)) {
        variables.write('''

  /// Asset derived from `${fil.path}`, with ${fil.statSync().size.toBytes} size.
  /// 
  /// ```dart
  /// String value = ${dir.name}.${fil.name};
  /// ```
  static const String ${fil.name} = '${fil.path}';
''');
      }

      classes.write('''
/// An asset class scanned from `${dir.path}`, containing ${dir.listSync().whereType<File>().length} files.
/// 
/// ```dart
/// String value = ${dir.name}.value;
/// ```
class ${dir.name} {$variables
}

''');
    }

    return '''
// Dart Fusion Auto-Generated Asset Scanner
// Created at ${DateTime.now()}
// 🍔 [Buy me a coffee](https://www.buymeacoffee.com/nialixus) 🚀
// ignore_for_file: constant_identifier_names

$classes
''';
  }
}

extension DirectoryListExtension on List<Directory> {
  void toPubspec() {
    File pubspec = File('pubspec.yaml');
    List<String> lines = pubspec.readAsLinesSync();
    int flutterIndex = lines.lastIndexWhere((line) => line.trim() == 'flutter:');
    int assetsIndex = lines.lastIndexWhere((line) => line.trim() == 'assets:');
    if (flutterIndex == -1) {
      lines.insert(lines.length - 1, 'flutter:\n  assets:');
    } else {
      if (assetsIndex == -1) {
        lines.insert(flutterIndex + 1, '  assets:');
      }
    }

    for (var directory in this) {
      int assetsIndex = lines.lastIndexWhere((line) => line.trim() == 'assets:');
      int directoryIndex = lines.lastIndexWhere((line) => line.trim() == '- ${directory.path}/');
      if (directoryIndex == -1) {
        lines.insert(assetsIndex + 1, '    - ${directory.path}/');
      }
    }

    pubspec.writeAsStringSync(lines.join('\n'));
  }
}
