part of '../dart_fusion.dart';

Future<void> insertLocalization({required ArgResults from}) async {
  try {
    if (from['help'] == true) {
      throw '\x1B[0mAvailable commands :';
    } else {
      String base = from['from'];
      List<String> target = from['to'];
      File input = File(from['input']);
      String? model = from['model'];
      Map<String, dynamic> json = jsonDecode(input.readAsStringSync());
      if (model != null) {
        File(model)
          ..parent.createSync(recursive: true)
          ..writeAsStringSync(json.model(name: File(model).name.capitalize, isRoot: true));
      }
      // for (var lang in target..removeWhere((e) => e == base)) {
      //   final translation = await json.translate(from: base, to: lang);
      //   File('${input.parent.path}/$lang.json')
      //       .writeAsStringSync(const JsonEncoder.withIndent('  ').convert(translation));
      //   stdout.writeln();
      // }
    }
  } catch (e) {
    print('\n\x1B[31m$e\x1B[0m\n\n'
        '+---------------+-----------------------------------------------------------------------+\n'
        '| OPTION\t| DESCRIPTION\t\t\t\t\t\t\t\t|\n'
        '+---------------+-----------------------------------------------------------------------+\n'
        '| -i, --input\t| Input directory of where the JSON base translation took place.\t|\n'
        '| \t\t| \x1B[2mdefault to \x1B[0m\x1B[33m"assets/translation/en.json"\x1B[0m\t\t\t\t|\n'
        '| --from\t| Base language used for translation\t\t\t\t\t|\n'
        '| \t\t| \x1B[2mdefault to \x1B[0m\x1B[33m"en"\x1B[0m\t\t\t\t\t\t\t|\n'
        '| --to\t\t| Targeted translation languages\t\t\t\t\t|\n'
        '| \t\t| \x1B[2mdefault to \x1B[0m\x1B[33m$languages\x1B[0m\t\t\t\t\t\t|\n'
        '| -h, --help\t| Print this usage information.\t\t\t\t\t\t|\n'
        '+---------------+-----------------------------------------------------------------------+\n'
        '\nUsage : '
        '\n- \x1B[32mdart\x1B[0m run \x1B[34mdart_fusion\x1B[0m localize');
  }
}

extension JSONExtension on Map<String, dynamic> {
  String generateDartClasses(String className, Map<String, dynamic> jsonMap, bool isRoot) {
    StringBuffer buffer = StringBuffer();

    if (isRoot) {
      buffer.write('class $className {\n');
    } else {
      buffer.write('class $className {\n  const $className();\n');
    }

    // Generate properties or getters based on the root level
    for (var key in jsonMap.keys) {
      if (jsonMap[key] is Map<String, dynamic>) {
        buffer.write('  ${key.capitalize} get $key => const ${key.capitalize}();\n');
        buffer.write(generateDartClasses(key.capitalize, jsonMap[key], false));
      } else {
        buffer.write(isRoot ? '  static String $key = \'$key\'.tr();\n' : '  String get $key => \'$key\'.tr();\n');
      }
    }

    buffer.write('}\n');

    return buffer.toString();
  }

  String model({
    required String name,
    bool isRoot = false,
  }) {
    StringBuffer buffer = StringBuffer();
    for (var value in entries) {
      if (value.value is Map<String, dynamic>) {
        print(value.value);
        buffer.write('class ${value.key} {');
      } else {
        buffer.write(isRoot ?'static String ${value.value} = ' 'class ${value.key} {');
      }
    }

    return '''
// Dart Fusion Auto-Generated Easy Localization
// Created at ${DateTime.now()}
// 🍔 [Buy me a coffee](https://www.buymeacoffee.com/nialixus) 🚀
// ignore_for_file: constant_identifier_names
import 'package:easy_localization/easy_localization.dart';

$buffer
''';
  }

  Future<Map<String, dynamic>> translate({required String from, required String to}) async {
    Map<String, dynamic> result = {};
    int index = 0;

    for (var item in entries) {
      try {
        if (item.value is Map<String, dynamic>) {
          result[item.key] = await (item.value as Map<String, dynamic>).translate(from: from, to: to); // Recursive call
        } else {
          Iterable<String> values = item.value.toString().trim().split(RegExp(r'(?={.*?})|(?<=\w})'));
          List<String> newValues = [];
          for (var value in values) {
            if (value.trim().startsWith('{') || RegExp(r'^\W+$').hasMatch(value)) {
              newValues.add(value);
            } else {
              final translation = await processing(text: value, from: from, to: to);
              newValues.add(translation != null
                  ? value.endsWith(' ')
                      ? '$translation '
                      : translation
                  : value);
            }
          }
          result[item.key] = newValues.join();
        }
      } catch (e) {
        stderr.writeln('ERROR: $e');
        result[item.key] = item.value;
      }
      var percentage = '${(((index + 1) / length) * 100).toInt()}%';
      stdout.write(
          '\rTranslating \x1B[33m$from\x1B[0m to \x1B[33m$to\x1B[0m [$percentage] ${percentage == '100%' ? '\x1B[32m✓\x1B[0m' : ''}          ');
      index++;
    }

    return result;
  }
}

Future<String?> processing({required String text, required String from, required String to}) async {
  Map<String, dynamic> json = {};
  try {
    final response = await http.get(Uri.parse('https://t.song.work/api?text=$text&from=$from&to=$to'));
    json = jsonDecode(response.body);
    return json['result']!;
  } catch (e) {
    if (json.isNotEmpty) {
      print('\n\x1B[31m$json\x1B[0m');
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
