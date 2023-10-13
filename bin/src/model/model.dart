part of '../../dart_fusion.dart';

/// Main function to update dart model based on given annotation.
void insertModel({required ArgResults from}) {
  try {
    if (from['help'] == true) {
      throw '\x1B[0mAvailable commands :';
    } else {
      String dir = from['input']!;
      List<File> files =
          Directory(dir.endsWith('/') ? dir.substring(0, dir.length - 1) : dir)
              .listSync(recursive: true)
              .whereType<File>()
              .where((e) =>
                  e.path.split('.').last.trim() == 'dart' &&
                  e
                      .readAsStringSync()
                      .contains(RegExp(r'(?=@Model)|(?=@model)')))
              .toList();
      for (int index = 0; index < files.length; index++) {
        ModelParser.run(files.elementAt(index));
        stdout.write('\rUpdating model ${index + 1}/${files.length} ');
      }
      print('\n\x1B[32m${files.map((e) => '${e.path} ✔️').join('\n')}\x1B[0m');
    }
  } catch (e) {
    print('\n\x1B[31m$e\x1B[0m\n\n'
        '+---------------+-----------------------------------------------+\n'
        '| OPTION\t| DESCRIPTION\t\t\t\t\t|\n'
        '+---------------+-----------------------------------------------+\n'
        '| -i, --input\t| Input directory of the models.\t\t|\n'
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
    try {
      int index = indexWhere((e) => e.trim().startsWith(part.first));
      if (index == -1) {
        index = lastIndexWhere((e) => e.startsWith('}'));
        insert(index, replacement(false));
      } else {
        List<int> indexes = [index];
        while (!this[index].trim().endsWith(part.last) || index < length) {
          if (this[index].trim().endsWith(part.last)) break;
          index++;
          indexes.add(index);
        }
        removeRange(indexes.first, indexes.last + 1);
        insert(indexes.first, replacement(true));
      }
    } catch (e) {
      /* do nothing */
    }
  }

  bool contain(Pattern pattern, {required List<String> sources}) {
    try {
      bool existed = false;
      for (var source in sources) {
        Iterable<String> part = source.split('...').map((e) => e.trim());
        int index = indexWhere((e) => e.trim().startsWith(part.first));
        if (index == -1) {
          existed = false;
        } else {
          List<int> indexes = [index];
          while (!this[index].trim().endsWith(part.last) || index < length) {
            if (this[index].trim().endsWith(part.last)) break;
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
    List<int> result = [-1, -1];
    for (var source in sources) {
      try {
        Iterable<String> part = source.split('...').map((e) => e.trim());
        int index = indexWhere((e) => e.trim().startsWith(part.first));
        List<int> indexes = [index];
        while (!this[index].trim().endsWith(part.last) || index < length) {
          if (this[index].trim().endsWith(part.last)) break;
          index++;
          indexes.add(index);
        }
        result = [indexes.first, indexes.last];
      } catch (e) {
        result = [-1, -1];
      }
      if (result.contains(-1)) {
        continue;
      } else {
        break;
      }
    }
    return result;
  }
}

class ModelParser {
  const ModelParser({
    required this.end,
    required this.name,
    required this.test,
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
  final bool immutable;
  final bool test;
  final int begin;
  final int end;

  static File run(File file) {
    var data = file
        .readAsStringSync()
        .split(RegExp(r'(?=@Model)|(?=@model)'))
        .map((e) {
      if (e.trim().startsWith(RegExp(r'(?=@Model)|(?=@model)'))) {
        final value = e.split('\n');
        bool noToJSON =
            value.contain('toJSON: false', sources: ['@Model(...)']);
        bool noCopyWith =
            value.contain('copyWith: false', sources: ['@Model(...)']);
        bool noFromJSON =
            value.contain('fromJSON: false', sources: ['@Model(...)']);
        bool noImmutable =
            value.contain('immutable: false', sources: ['@Model(...)']);
        bool noTest = value.contain('test: false', sources: ['@Model(...)']);
        final range = value.range(['@Model(...)', '@model']);
        List<VariableParser> variables = VariableParser.fromString(e);
        StringBuffer buffer = StringBuffer();
        final model = ModelParser(
          end: value.length,
          begin: 0,
          test: !noTest,
          name: RegExp(r'(?<=class\s).+?\w+')
              .allMatches(value[range.last + 1])
              .first
              .group(0)!,
          toJSON: !noToJSON,
          copyWith: !noCopyWith,
          fromJSON: !noFromJSON,
          immutable: !noImmutable,
        );

        if (model.test) {
          value.replace('static ${model.name} get test...}',
              replacement: (exist) {
            buffer.clear();
            for (var variable in variables) {
              buffer.write(model.immutable
                  ? '\n\t\t\t${variable.name}: '
                  : '\n\t\t\t..${variable.name} = ');
              if (variable.defaultsTo != null) {
                buffer.write('${variable.defaultsTo}');
              } else {
                switch (variable.type) {
                  case 'String':
                    buffer.write("'This is a sample ${variable.name}'");
                    break;
                  case 'int':
                    buffer.write('0');
                    break;
                  case 'double':
                    buffer.write('1.0');
                    break;
                  case 'bool':
                    buffer.write('false');
                    break;
                  default:
                    if (variable.type.startsWith('List')) {
                      buffer.write('[]');
                      break;
                    } else {
                      buffer.write('${variable.type}.test');
                      break;
                    }
                }
              }

              buffer.write(model.immutable ? ',' : '');
            }
            return '${exist ? '' : '\n'}'
                '\tstatic ${model.name} get test {\n'
                '${model.immutable ? '\t\treturn ${variables.any((e) => e.type != 'String' || e.type != 'int' || e.type != 'double' || e.type != 'bool') ? 'const ' : ''}${model.name}($buffer\n\t\t)' : '\t\treturn ${model.name}()$buffer\n\t\t'}'
                ';\n\t}';
          });
        }

        if (model.copyWith) {
          value.replace('\t${model.name} copyWith...}', replacement: (exist) {
            buffer.clear();
            for (var variable in variables) {
              buffer.write("\t\t${variable.type}? ${variable.name}, \n");
            }
            buffer.write('\t}) {\n');
            if (model.immutable) {
              buffer.write('\t\treturn ${model.name}(\n');
              for (var variable in variables) {
                buffer.write(
                    '\t\t\t${variable.name}: ${variable.name} ?? this.${variable.name},\n');
              }
              buffer.write('\t\t);\n');
            } else {
              buffer.write('\t\treturn ${model.name}()\n');
              for (int index = 0; index < variables.length; index++) {
                buffer.write(
                    '\t\t\t..${variables[index].name} = ${variables[index].name} ?? this.${variables[index].name}${index == variables.length - 1 ? ';\n' : '\n'}');
              }
            }

            return '${exist ? '' : '\n\t@override\n'}'
                '\t${model.name} copyWith({\n'
                '$buffer'
                '\t}';
          });
        }

        if (model.toJSON) {
          value.replace('\tJSON get toJSON...;', replacement: (exist) {
            buffer.clear();
            for (var variable in variables) {
              buffer.write(
                  "\t\t'${variable.key ?? variable.name}': ${variable.name}${variable.toJSON ? '${variable.nullable ? '?' : ''}.toJSON' : ''}, \n");
            }
            return '${exist ? '' : '\n\t@override\n'}'
                '\tJSON get toJSON => {\n'
                '$buffer'
                '\t\t...super.toJSON, \n'
                '\t};';
          });
        }

        if (model.fromJSON) {
          value.replace('static ${model.name} fromJSON...}',
              replacement: (exist) {
            buffer.clear();
            for (var variable in variables) {
              String prefix = variable.nullable ? 'value.maybeOf' : 'value.of';
              String suffixNullable =
                  variable.nullable && variable.defaultsTo != null
                      ? ' ?? ${variable.defaultsTo}'
                      : '';
              String suffix = !variable.nullable && variable.defaultsTo != null
                  ? ', const ${variable.defaultsTo}'
                  : '';
              String content = variable.fromJSON
                  ? variable.type.contains('List')
                      ? "$prefix<List<JSON>>('${variable.key ?? variable.name}'$suffix).map(${variable.type.replaceAll(RegExp(r'.+?(?<=<)|(?=>).+?'), '')}.fromJSON).toList()$suffixNullable"
                      : "${variable.type}.fromJSON($prefix<JSON>('${variable.key ?? variable.name}'$suffix)$suffixNullable${suffixNullable.isNotEmpty ? '.toJSON' : ''})"
                  : "$prefix<${variable.type}>('${variable.key ?? variable.name}'$suffix)$suffixNullable";
              if (model.immutable) {
                buffer.write("\n\t\t\t${variable.name}: $content,");
              } else {
                buffer.write("\n\t\t\t..${variable.name} = $content");
              }
            }
            String content = model.immutable
                ? '\t\treturn ${model.name}('
                    '$buffer'
                    '\n\t\t)'
                : '\t\treturn ${model.name}()' '$buffer';
            return '${exist ? '' : '\n'}'
                '\tstatic ${model.name} fromJSON(JSON value) {\n'
                '$content'
                ';\n\t}';
          });
        }
        return value.join('\n');
      }
      return e;
    }).join('');
    if (data.contains('immutable: false') &&
        !data.contains('must_be_immutable')) {
      data = '// ignore_for_file: must_be_immutable\n\n$data';
    }
    file.writeAsStringSync(data);
    return file;
  }

  @override
  String toString() => '$runtimeType('
      'begin: $begin, '
      'end: $end, '
      'name: $name, '
      'to_json: $toJSON, '
      'from_json: $fromJSON, '
      'copy_with: $copyWith, '
      'test: $test, '
      'immutable: $immutable)';
}

class VariableParser {
  const VariableParser({
    this.key,
    required this.type,
    required this.name,
    this.toJSON = false,
    this.fromJSON = false,
    this.nullable = false,
    this.defaultsTo,
  });
  final String? key;
  final String name;
  final String type;
  final bool nullable;
  final bool toJSON;
  final bool fromJSON;
  final String? defaultsTo;

  static List<VariableParser> fromString(String data) {
    List<VariableParser> objects = [];
    final value = data.split(RegExp(r'(?=@Variable)|(?=@variable)'));
    for (int index = 0; index < value.length; index++) {
      if (value[index].startsWith(RegExp(r'(?=@Variable)|(?=@variable)'))) {
        final values = value[index].split('\n');
        final range = values.range(['@Variable...)\n', '@variable']);
        String line = values[range.last + 1];
        final key = RegExp(r'''(?<=name:).*(?<='|")''')
            .stringMatch(values[range.last])
            ?.trim()
            .replaceAll(RegExp(r'''('|")'''), '');
        bool toJSON =
            values.contain('toJSON: true', sources: ['@Variable(...)']);
        bool fromJSON =
            values.contain('fromJSON: true', sources: ['@Variable(...)']);
        List<String> variable = line
            .replaceAll(RegExp(r'final |const |static |;'), '')
            .trim()
            .split(' ');

        String? defaultsTo = RegExp(r'@Variable\(defaultsTo:\s*([^;]+)\)')
            .firstMatch(values.map((e) => e.trim()).join(''))
            ?.group(1)
            ?.trim();

        final model = VariableParser(
            key: key,
            defaultsTo: defaultsTo,
            type: variable[0].trim().replaceAll('?', ''),
            name: variable[1],
            nullable: variable[0].trim().endsWith('?'),
            toJSON: toJSON,
            fromJSON: fromJSON);
        objects.add(model);
      }
    }
    return objects;
  }

  @override
  String toString() {
    return '$runtimeType('
        'key: $key, '
        'name; $name, '
        'type: $type, '
        'nullable: $nullable, '
        'defaults_to; $defaultsTo, '
        'toJSON: $toJSON, '
        'fromJSON: $fromJSON)';
  }
}
