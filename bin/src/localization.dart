part of '../dart_fusion.dart';

Future<void> insertLocalization({required ArgResults from}) async {
  try {
    if (from['help'] == true) {
      throw '\x1B[0mAvailable commands :';
    } else {
      String base = from['from'];
      String api = from['api-key']!;
      List<String> target = from['to'];
      File input = File(from['input']);
      Map<String, dynamic> json = jsonDecode(input.readAsStringSync());
      for (var lang in target..removeWhere((e) => e == base)) {
        final translation = await json.translate(from: base, to: lang, api: api);
        File('${input.parent.path}/$lang.json')
            .writeAsStringSync(const JsonEncoder.withIndent('  ').convert(translation));
      }
    }
  } catch (e) {
    print('\n\x1B[31m$e\x1B[0m\n\n'
        '+---------------+-----------------------------------------------------------------------+\n'
        '| OPTION\t| DESCRIPTION\t\t\t\t\t\t\t\t|\n'
        '+---------------+-----------------------------------------------------------------------+\n'
        '| --api-key\t| Lecto api key \x1B[33m(required)\x1B[0m\t\t\t\t\t\t|\n'
        '| -i, --input\t| Input directory of where the JSON base translation took place.\t|\n'
        '| \t\t| \x1B[2mdefault to \x1B[0m\x1B[33m"assets/translation/en.json"\x1B[0m\t\t\t\t|\n'
        '| --from\t| Base language used for translation\t\t\t\t\t|\n'
        '| \t\t| \x1B[2mdefault to \x1B[0m\x1B[33m"en"\x1B[0m\t\t\t\t\t\t\t|\n'
        '| --to\t\t| Targeted translation languages\t\t\t\t\t|\n'
        '| \t\t| \x1B[2mdefault to \x1B[0m\x1B[33m$languages\x1B[0m\t\t\t\t\t\t|\n'
        '| -h, --help\t| Print this usage information.\t\t\t\t\t\t|\n'
        '+---------------+-----------------------------------------------------------------------+\n'
        '\nUsage : '
        '\n- \x1B[32mdart\x1B[0m run \x1B[34mdart_fusion\x1B[0m localize --api-key=\x1B[33m"4Z5H0ZS-QHZM2Z8-NTYP640-38D9RFF"\x1B[0m');
  }
}

extension JSONExtension on Map<String, dynamic> {
  Future<Map<String, dynamic>> translate({required String from, required String to, required String api}) async {
    Map<String, dynamic> result = {};
    int index = 0;

    for (var item in entries) {
      try {
        if (item.value is Map<String, dynamic>) {
          result[item.key] =
              await (item.value as Map<String, dynamic>).translate(from: from, to: to, api: api); // Recursive call
        } else {
          List<String> values = item.value.toString().split(RegExp(r'(?={{)|(?<=}})'));
          List<String> newValues = [];
          for (var value in values) {
            if (value.trim().startsWith('{{')) {
              newValues.add(value);
            } else {
              final translation = await processing(text: item.value, from: from, to: to, api: api);
              newValues.add(translation ?? value);
            }
          }
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

Future<String?> processing(
    {required String text, required String from, required String to, required String api}) async {
  Map<String, dynamic> json = {};
  try {
    final response = await http.post(Uri.parse('https://api.lecto.ai/v1/translate/text'),
        headers: {
          'X-API-Key': api,
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          "texts": [text],
          "to": [to],
          "from": from
        }));
    json = jsonDecode(response.body);
    return json['translations']![0]!['translated']![0];
  } catch (e) {
    if (json.isNotEmpty) {
      print('\n\x1B[31m$json\x1B[0m');
    } else {
      print('\n\x1B[33m$e\x1B[0m');
    }
    return null;
  }
}

List<String> languages = [
  "af",
  "sq",
  "am",
  "ar",
  "hy",
  "az",
  "be",
  "bel",
  "bn",
  "bs",
  "bg",
  "ca",
  "ceb",
  "zh-CN",
  "zh-TW",
  "hr",
  "cs",
  "da",
  "nl",
  "en",
  "et",
  "tl",
  "fi",
  "fr",
  "fy",
  "gl",
  "ka",
  "de",
  "el",
  "gu",
  "ht",
  "ha",
  "he",
  "hi",
  "hu",
  "is",
  "ig",
  "id",
  "ga",
  "it",
  "ja",
  "kn",
  "kk",
  "km",
  "ko",
  "lo",
  "lv",
  "lt",
  "lb",
  "mk",
  "mg",
  "ms",
  "ml",
  "mr",
  "mn",
  "my",
  "ne",
  "nb",
  "no",
  "or",
  "ps",
  "fa",
  "pl",
  "pt",
  "pt-BR",
  "pt-PT",
  "pa",
  "ro",
  "ru",
  "gd",
  "sr",
  "sd",
  "si",
  "sk",
  "sl",
  "so",
  "es",
  "su",
  "sw",
  "sv",
  "ta",
  "th",
  "tr",
  "uk",
  "ur",
  "uz",
  "vi",
  "cy",
  "xh",
  "yi",
  "yo",
  "zu"
];
