// ignore_for_file: avoid_print

part of '../dart_fusion.dart';

void insertModel({required ArgResults from}) {
  try {
    if (from['help'] == true) {
      throw '\x1B[0mAvailable commands :';
    } else {
      String input = from['input']!.toString();
      for (var file in Directory(input).listSync(recursive: true).whereType<File>()) {
        List<String> lines = file.readAsLinesSync();
        List<ObjectParser> objects = [];
        for (int x = 0; x < lines.length; x++) {
          if (lines[x].trim().startsWith('@DVariable')) {
            objects.add(ObjectParser.fromString(lines[x + 1]));
          }
        }

        // Add toJSON
        lines.replace('JSON get toJSON ...\t}', replacement: (value) {
          StringBuffer buffer = StringBuffer();
          if (!value) buffer.write('\n  @override\n');
          buffer.write('\tJSON get toJSON => {\n');
          for (var object in objects) {
            buffer.write("\t\t'${object.name}': ${object.name},\n");
          }
          buffer
            ..write('\t\t...super.toJSON,\n')
            ..write('\t};');
          return buffer.toString();
        });

        file.writeAsStringSync(lines.join("\n"));
      }
    }
  } catch (e) {
    print('\n\x1B[31m$e\x1B[0m\n\n'
        '+---------------+-----------------------------------------------+\n'
        '| OPTION\t| DESCRIPTION\t\t\t\t\t|\n'
        '+---------------+-----------------------------------------------+\n'
        '| -i, --input\t| Input directory of the models.\t\t|\n'
        '| \t\t| \x1B[2mdefault to \x1B[0m\x1B[33m"lib/src/models"\x1B[0m\t\t\t|\n'
        '| -h, --help\t| Print this usage information.\t\t\t|\n'
        '+---------------+-----------------------------------------------+\n'
        '\nUsage : '
        '\n- \x1B[32mdart\x1B[0m run \x1B[34mdart_fusion\x1B[0m model -i \x1B[33m"lib/src/models"\x1B[0m');
  }
}

extension StringListExtension on List<String> {
  void replace(
    String source, {
    required String Function(bool exist) replacement,
  }) {
    final part = source.split('...').map((e) => e.trim());
    int index = indexWhere((e) => e.trim().startsWith(part.first));
    if (index == -1) {
      index = lastIndexWhere((e) => e.trim().contains(part.last));
      insert(index, replacement(false));
    } else {
      List<int> indexes = [index];
      while (!this[index].trim().contains(part.last)) {
        index++;
        indexes.add(index);
        print(this[index]);
        print(index);
      }
      removeRange(indexes.first, indexes.last + 1);
      insert(indexes.first, replacement(true));
    }
  }
}

class ClassParser {
  const ClassParser({required this.name});
  final String name;

  factory ClassParser.fromString(String value) {
    var content = value.split(' ')..removeAt(0);
    return ClassParser(name: content.first);
  }

  @override
  String toString() => '$runtimeType(name: $name)';
}

class VariableParser {
  const VariableParser({required this.type, required this.name});
  final String name, type;

  factory VariableParser.fromString(String value) {
    final content = value.replaceAll(RegExp(r'(final )|;'), '').split('=').first.split(' ').where((e) => e.isNotEmpty);
    print(content);
    return VariableParser(type: content.first, name: content.last);
  }

  @override
  String toString() => '$runtimeType(name; $name, type: $type)';
}
