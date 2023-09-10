// ignore_for_file: avoid_print

part of '../dart_fusion.dart';

void insertModel({required ArgResults from}) {
  try {
    if (from['help'] == true) {
      throw '\x1B[0mAvailable commands :';
    } else {
      String input = from['input']!.toString();

      for (var file in Directory(input).listSync(recursive: true).whereType<File>()) {
        ModelParser.fromFile(file);
        // for (int index = 0; index < lines.length; index++) {
        //   if (lines[index].trim().startsWith(RegExp(r'@model|@Model'))) {
        //     print('index:${lines[index]}');
        //   }
        // }
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
      insert(index + 1, replacement(false));
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

  bool contain(Pattern pattern, {required List<String> sources}) {
    try {
      bool existed = false;
      for (var source in sources) {
        Iterable<String> part = source.split('...').map((e) => e.trim());
        int index = indexWhere((e) => e.trim().startsWith(part.first));
        if (index == 1) {
          existed = false;
        } else {
          List<int> indexes = [index];
          while (!this[index].contains(part.last) || index == length) {
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
        }
      }

      return existed;
    } catch (e) {
      return false;
    }
  }

  List<int> range(List<String> sources) {
    try {
      List<int> ranges = [-1, -1];
      for (var source in sources) {
        Iterable<String> part = source.split('...').map((e) => e.trim());
        int index = indexWhere((e) => e.trim().startsWith(part.first));
        List<int> indexes = [index];
        if (index == 1) {
          throw 'Nothing found';
        } else {
          while (!this[index].contains(part.last) || index == length) {
            index++;
            indexes.add(index);
          }
        }
        ranges = [indexes.first, indexes.last];
      }
      return ranges;
    } catch (e) {
      return [-1, -1];
    }
  }
}

class ModelParser {
  const ModelParser({
    this.doc,
    required this.end,
    required this.name,
    required this.begin,
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
  final int begin;
  final int end;

  static void fromFile(File file) {
    final data = file.readAsStringSync().split(RegExp(r'(?=@Model)|(?=@model)')).map((e) {
      if (e.trim().startsWith(RegExp(r'(?=@Model)|(?=@model)'))) {
        final value = e.split('\n');
        bool noToJSON = value.contain('toJSON: false', sources: ['@Model(...)']);
        bool noCopyWith = value.contain('copyWith: false', sources: ['@Model(...)']);
        bool noFromJSON = value.contain('fromJSON: false', sources: ['@Model(...)']);
        bool noImmutable = value.contain('immutable: false', sources: ['@Model(...)']);
        final model = ModelParser(
          end: value.length,
          begin: 0,
          name: 'name',
          toJSON: !noToJSON,
          copyWith: !noCopyWith,
          fromJSON: !noFromJSON,
          immutable: !noImmutable,
        );
        if (model.toJSON) {
          value.replace('\tJSON get toJSON...;', replacement: (exist) {
            return '${exist ? '' : '\n\t@override\n'}'
                '\tJSON get toJSON => {\n'
                '\t\t...super.toJSON, \n'
                '\t};';
          });
        }
        return value.join('\n');
      }
      return e;
    }).join('');
    file.writeAsStringSync(data);

    // for (int index = 0; index < lines.length; index++) {
    //   if (lines[index].trim().startsWith('@Model')) {
    //     final value = lines.sublist(index);
    //     bool noToJSON = value.contain('toJSON: false', sources: ['@Model(...)']);
    //     bool noCopyWith = value.contain('copyWith: false', sources: ['@Model(...)']);
    //     bool noFromJSON = value.contain('fromJSON: false', sources: ['@Model(...)']);
    //     bool noImmutable = value.contain('immutable: false', sources: ['@Model(...)']);
    //     final ranges = value.range(['@Model(...}']);
    //     if (!ranges.contains(-1)) {
    //       print(value.sublist(ranges.first, ranges.last + 1).join('\n'));
    //     }
    //     final model = ModelParser(
    //       end: ranges.last,
    //       begin: ranges.first,
    //       name: 'name',
    //       toJSON: !noToJSON,
    //       copyWith: !noCopyWith,
    //       fromJSON: !noFromJSON,
    //       immutable: !noImmutable,
    //     );
    //     if (!(model.begin == -1 || model.end == -1)) models.add(model);
    //   }
    // }
    // return models;
  }

  @override
  String toString() => '$runtimeType('
      'begin: $begin, '
      'end: $end, '
      'doc: $doc, '
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
