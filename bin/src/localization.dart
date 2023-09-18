part of '../dart_fusion.dart';

Future<void> insertLocalization({required ArgResults from}) async {
  try {
    if (from['help'] == true) {
      throw '\x1B[0mAvailable commands :';
    } else {
      String base = from['from'];
      List<String> target = from['to'];
      File input = File(from['input']);
      Map<String, dynamic> json = jsonDecode(input.readAsStringSync());
      for (var lang in target..removeWhere((e) => e == base)) {
        final translation = await json.translate(from: base, to: lang);
        File('${input.parent.path}/$lang.json')
            .writeAsStringSync(const JsonEncoder.withIndent('  ').convert(translation));
      }
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
  Future<Map<String, dynamic>> translate({required String from, required String to}) async {
    Map<String, dynamic> result = {};
    int index = 0;

    for (var item in entries) {
      try {
        if (item.value is Map<String, dynamic>) {
          result[item.key] = await (item.value as Map<String, dynamic>).translate(from: from, to: to); // Recursive call
        } else {
          Iterable<String> values = item.value.toString().trim().split(RegExp(r'(?={{)|(?<=}})'));
          List<String> newValues = [];
          for (var value in values) {
            if (value.trim().startsWith('{{') || RegExp(r'^\W+$').hasMatch(value)) {
              newValues.add(value);
            } else {
              final translation = await processing(text: value, from: from, to: to);
              print("VALUE: $value has SPACE: ${value.endsWith(" ")}");
              // ignore: unnecessary_string_escapes
              newValues.add(translation != null
                  ? value.endsWith(' ')
                      ? '$translation '
                      : translation
                  : value);
            }
          }

          // ignore: unnecessary_string_escapes
          result[item.key] = newValues.join();
        }
      } catch (e) {
        stderr.writeln('ERROR: $e');
        result[item.key] = item.value;
      }

      stdout.write('\rTranslating $to ${(((index + 1) / length) * 100).toInt()}%          ');
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
