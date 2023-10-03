part of '../../dart_fusion.dart';

Future<void> insertLocalization({required ArgResults from}) async {
  try {
    if (from['help'] == true) {
      throw '\x1B[0mAvailable commands :';
    } else {
      String base = from['from'];
      List<String> exclude = from['exclude'];
      List<String> target = (from['to'] as List<String>)
        ..removeWhere((e) => exclude.contains(e));
      File input = File(from['input']);
      File? output = from['output'] != null ? File(from['output']!) : null;
      Map<String, dynamic> json = jsonDecode(input.readAsStringSync());
      if (output != null) {
        final file = output
          ..parent.createSync(recursive: true)
          ..writeAsStringSync(
              json.model(className: output.name.capitalize, isRoot: true));
        print(
            'Generating \x1B[33m${input.path}\x1B[0m to \x1B[33m${file.path}\x1B[0m \x1B[32m✔︎\x1B[0m');
      }
      if (from['translate'] == true) {
        int progress = 0;
        for (var lang in target..removeWhere((e) => e == base)) {
          final translation = await json.translate(
            from: base,
            to: lang,
            callback: (to) {
              progress++;
              var percentage =
                  '${((progress / json.totalLength) * 100).toInt()}%';
              stdout.write(
                  '\rTranslating \x1B[33m$base\x1B[0m to \x1B[33m$to\x1B[0m [$percentage] ${percentage == '100%' ? '\x1B[32m✓\x1B[0m' : ''}          ');
            },
          );
          File('${input.parent.path}/$lang.json').writeAsStringSync(
              const JsonEncoder.withIndent('  ').convert(translation));
          stdout.writeln();
          progress = 0;
        }
      }
    }
  } catch (e) {
    print('\n\x1B[31m$e\x1B[0m\n\n'
        '+---------------+-----------------------------------------------------------------------+\n'
        '| OPTION\t| DESCRIPTION\t\t\t\t\t\t\t\t|\n'
        '+---------------+-----------------------------------------------------------------------+\n'
        '| -i, --input\t| Input directory of where the JSON base translation took place.\t|\n'
        '| \t\t| \x1B[2mdefault to \x1B[0m\x1B[33m"assets/translation/en.json"\x1B[0m\t\t\t\t|\n'
        '| -o, --output\t| Generating json to \x1B[33measy_localization\x1B[0m model\t\t\t\t|\n'
        '| --from\t| Base language used for translation\t\t\t\t\t|\n'
        '| \t\t| \x1B[2mdefault to \x1B[0m\x1B[33m"en"\x1B[0m\t\t\t\t\t\t\t|\n'
        '| --to\t\t| Targeted translation languages\t\t\t\t\t|\n'
        '| \t\t| \x1B[2mdefault to \x1B[0m\x1B[33m$languages\x1B[0m\t\t\t\t\t\t\t\t\t|\n'
        '| --exclude\t| Excluded translation languages\t\t\t\t\t|\n'
        '| -h, --help\t| Print this usage information.\t\t\t\t\t\t|\n'
        '+---------------+-----------------------------------------------------------------------+\n'
        '\nUsage : '
        '\n- \x1B[32mdart\x1B[0m run \x1B[34mdart_fusion\x1B[0m localize');
  }
}

extension JSONExtension on Map<String, dynamic> {
  String generateDartClasses(
      String className, Map<String, dynamic> jsonMap, bool isRoot) {
    StringBuffer buffer = StringBuffer();

    if (isRoot) {
      buffer.write('class $className {\n');
    } else {
      buffer.write('class $className {\n  const $className();\n');
    }

    // Generate properties or getters based on the root level
    for (var key in jsonMap.keys) {
      if (jsonMap[key] is Map<String, dynamic>) {
        buffer.write(
            '  ${key.capitalize} get $key => const ${key.capitalize}();\n');
        buffer.write(generateDartClasses(key.capitalize, jsonMap[key], false));
      } else {
        buffer.write(isRoot
            ? '  static String ${key.name} = \'$key\'.tr();\n'
            : '  String get ${key.name} => \'$key\'.tr();\n');
      }
    }

    buffer.write('}\n');

    return buffer.toString();
  }

  String model({
    required String className,
    bool isRoot = false,
  }) {
    List<String> result = [];
    void classes({
      required String name,
      required bool isRoot,
      required Map<String, dynamic> json,
      required String parent,
    }) {
      StringBuffer buffer = StringBuffer()
        ..write(''
            '\n/// ${isRoot ? 'Root' : 'Branch'} class of generated localization. This consist of ${json.entries.length} value'
            '\n///'
            '\n/// ```dart'
            '\n/// String value = ${parent.isEmpty ? '$className.value' : '$className.$parent.value'};'
            '\n/// ```'
            '\nclass $name {'
            '\n\t/// Default constant constructor of [$name]'
            '\n\t///'
            '\n\t/// ```dart'
            '\n\t/// $name ${name.toLowerCase()} = const $name();'
            '\n\t/// ```'
            '\n\tconst $name();');
      for (var value in json.entries) {
        final name = value.key.split('_').map((e) => e.capitalize).join();
        final parentKey =
            parent.isNotEmpty ? '$parent.${value.key}' : value.key;
        if (value.value is Map<String, dynamic>) {
          classes(
            name: name,
            isRoot: false,
            json: value.value,
            parent: parentKey,
          );
          buffer
            ..write('\n'
                '\n\t/// Branch value of [$name]'
                '\n\t///'
                '\n\t/// ```dart'
                '\n\t/// $name ${value.key.toLowerCase()} = $className.$parentKey'
                '\n\t/// ```')
            ..write(isRoot
                ? '\n\tstatic $name ${value.key.toLowerCase()} = const $name();'
                : '\n\t$name get ${value.key.toLowerCase()} => const $name();');
        } else {
          buffer.write('\n'
              '\n\t/// String value of `${value.key}`.'
              '\n\t///');

          if (value.value.toString().contains(RegExp(r'{.*?}'))) {
            List<String> arguments = RegExp(r'{.*?}')
                .allMatches(value.value)
                .map((e) => (e.group(0) ?? "").replaceAll(RegExp(r'{|}'), ''))
                .where((e) => e.isNotEmpty)
                .toSet()
                .toList();
            buffer.write(""
                "\n\t/// ```dart"
                "\n\t/// String ${value.key.toLowerCase()} = $className.${parentKey.name}(");
            for (var args in arguments) {
              buffer.write(" $args: '$args',");
            }
            buffer.write(");"
                "\n\t/// print(${value.key.name.toLowerCase()}); /* ${value.value.toString().replaceAll('\n', '\n\t/// ')}"
                " */\n\t/// ```"
                "\n\t${isRoot ? 'static ' : ''}String ${value.key.name.toLowerCase()}({");
            for (var args in arguments) {
              buffer.write('\n\t\trequired String $args,');
            }
            buffer.write("\n\t}) => '$parentKey'.tr(namedArgs: {");
            for (var args in arguments) {
              buffer.write(" '$args': $args,");
            }
            buffer.write("});");
          } else {
            buffer
              ..write(""
                  "\n\t/// ```dart"
                  "\n\t/// String ${value.key.name.toLowerCase()} = $className.${parentKey.name};"
                  "\n\t/// print(${value.key.name.toLowerCase()}); /* ${value.value.toString().replaceAll('\n', '\n\t/// ')}"
                  " */\n\t/// ```")
              ..write(isRoot
                  ? "\n\tstatic String ${value.key.name.toLowerCase()} = '$parentKey'.tr();"
                  : "\n\tString get ${value.key.name.toLowerCase()} => '$parentKey'.tr();");
          }
        }
      }
      buffer.write('\n}');
      result.add(buffer.toString());
    }

    classes(
      name: className,
      isRoot: isRoot,
      json: this,
      parent: '',
    );

    return '''
// Dart Fusion Auto-Generated Easy Localization
// Created at ${DateTime.now()}
// 🍔 [Buy me a coffee](https://www.buymeacoffee.com/nialixus) 🚀
// ignore_for_file: constant_identifier_names, non_constant_identifier_names
import 'package:easy_localization/easy_localization.dart';
${result.reversed.join('\n')}
''';
  }

  int get totalLength {
    int length = 0;

    void counter(Map<String, dynamic> json) {
      for (var value in json.values) {
        if (value is Map<String, dynamic>) {
          counter(value);
        } else {
          length++;
        }
      }
    }

    counter(this);

    return length;
  }

  Future<Map<String, dynamic>> translate({
    required String from,
    required String to,
    required void Function(String to) callback,
  }) async {
    Map<String, dynamic> result = {};

    for (var item in entries) {
      try {
        if (item.value is Map<String, dynamic>) {
          result[item.key] = await (item.value as Map<String, dynamic>)
              .translate(from: from, to: to, callback: callback);
        } else {
          Iterable<String> values =
              item.value.toString().trim().split(RegExp(r'(?={.*?})|(?<=\w})'));
          List<String> newValues = [];
          for (var value in values) {
            if (value.trim().startsWith('{') ||
                RegExp(r'^\W+$').hasMatch(value)) {
              newValues.add(value);
            } else {
              final translation =
                  await processing(text: value, from: from, to: to);
              newValues.add(translation != null
                  ? value.endsWith(' ')
                      ? '$translation '
                      : translation
                  : value);
            }
          }
          result[item.key] = newValues.join();
          callback(to);
        }
      } catch (e) {
        stderr.writeln('ERROR: $e');
        result[item.key] = item.value;
        print('ERROR: $e');
      }
    }

    return result;
  }
}

Future<String?> processing(
    {required String text, required String from, required String to}) async {
  Map<String, dynamic> json = {};
  try {
    final response = await http
        .get(Uri.parse('https://t.song.work/api?text=$text&from=$from&to=$to'));
    json = jsonDecode(response.body);
    return json['result']!;
  } catch (e) {
    if (json.isNotEmpty) {
      print('\n\x1B[31m$json\x1B[0m');
      if (json.toString().contains('Please wait for a moment and retry.')) {
        await Future.delayed(const Duration(seconds: 1));
      }
    } else {
      print('\n\x1B[33m$e\x1B[0m');
    }
    return null;
  }
}

const List<String> languages = [
  "af",
  "sq",
  "am",
  "ar",
  "hy",
  "as",
  "ay",
  "az",
  "bm",
  "eu",
  "be",
  "bn",
  "bho",
  "bs",
  "bg",
  "ca",
  "ceb",
  "zh-CN",
  "zh",
  "zh-TW",
  "co",
  "hr",
  "cs",
  "da",
  "dv",
  "doi",
  "nl",
  "en",
  "eo",
  "et",
  "ee",
  "fil",
  "fi",
  "fr",
  "fy",
  "gl",
  "ka",
  "de",
  "el",
  "gn",
  "gu",
  "ht",
  "ha",
  "haw",
  "he",
  "hi",
  "hmn",
  "hu",
  "is",
  "ig",
  "ilo",
  "id",
  "ga",
  "it",
  "ja",
  "jv",
  "kn",
  "kk",
  "km",
  "rw",
  "gom",
  "ko",
  "kri",
  "ku",
  "ckb",
  "ky",
  "lo",
  "la",
  "lv",
  "ln",
  "lt",
  "lg",
  "lb",
  "mk",
  "mai",
  "mg",
  "ms",
  "ml",
  "mt",
  "mi",
  "mr",
  "mni-Mtei",
  "lus",
  "mn",
  "my",
  "ne",
  "no",
  "ny",
  "or",
  "om",
  "ps",
  "fa",
  "pl",
  "pt",
  "pa",
  "qu",
  "ro",
  "ru",
  "sm",
  "sa",
  "gd",
  "nso",
  "sr",
  "st",
  "sn",
  "sd",
  "si",
  "sk",
  "sl",
  "so",
  "es",
  "su",
  "sw",
  "sv",
  "tl",
  "tg",
  "ta",
  "tt",
  "te",
  "th",
  "ti",
  "ts",
  "tr",
  "tk",
  "ak",
  "uk",
  "ur",
  "ug",
  "uz",
  "vi",
  "cy",
  "xh",
  "yi",
  "yo",
  "zu"
];
