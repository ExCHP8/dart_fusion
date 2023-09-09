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
        for (int index = 0; index < lines.length; index++) {
          if (lines[index].trim().startsWith(RegExp(r'@model|@Model'))) {
            print('index:${lines[index]}');
          }
        }
        // List<VariableParser> objects = [];
        // for (int x = 0; x < lines.length; x++) {
        //   if (lines[x].trim().startsWith('@DVariable')) {
        //     objects.add(VariableParser.fromString(lines[x + 1]));
        //   }
        // }

        // Add toJSON
        // lines.replace('JSON get toJSON ...\t}', replacement: (value) {
        //   StringBuffer buffer = StringBuffer();
        //   if (!value) buffer.write('\n  @override\n');
        //   buffer.write('\tJSON get toJSON => {\n');
        //   for (var object in objects) {
        //     buffer.write("\t\t'${object.name}': ${object.name},\n");
        //   }
        //   buffer
        //     ..write('\t\t...super.toJSON,\n')
        //     ..write('\t};');
        //   return buffer.toString();
        // });

        file.writeAsStringSync(lines.join("\n"));
        print('Success motherfather');
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
      while (!this[index].trim().contains(part.last) || index == length) {
        index++;
        indexes.add(index);
      }
      removeRange(indexes.first, indexes.last + 1);
      insert(indexes.first, replacement(true));
    }
  }

  bool contain(String source, {required Pattern pattern, void Function(List<int> indexes)? result}) {
    final part = source.split('...').map((e) => e.trim());
    int index = indexWhere((e) => e.trim().startsWith(part.first));
    bool existed = false;
    if (index == 1) {
      existed = false;
    } else {
      List<int> indexes = [index];
      while (!this[index].trim().contains(part.last) || index == length) {
        index++;
        indexes.add(index);
      }
      for (var index in indexes) {
        if (this[index].trim().contains(pattern)) {
          existed = true;
          break;
        } else {
          continue;
        }
      }

      if (result != null) result(indexes);
    }
    return existed;
  }
}

class ClassGenerator {
  const ClassGenerator({
    this.doc,
    required this.name,
    required this.toJSON,
    required this.copyWith,
    required this.fromJSON,
    required this.immutable,
  });
  final String name;
  final bool toJSON;
  final bool copyWith;
  final bool fromJSON;
  final String? doc;
  final bool immutable;

  factory ClassGenerator.fromList(List<String> value) {
    return ClassGenerator(name: name, toJSON: toJSON, copyWith: copyWith, fromJSON: fromJSON, immutable: immutable);
  }

  @override
  String toString() => '$runtimeType('
      'doc: $doc'
      'name: $name, '
      'to_json: $toJSON, '
      'from_json: $fromJSON, '
      'copy_with: $copyWith, '
      'immutable: $immutable)';
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
