part of '../dart_fusion.dart';

Future<void> insertLocalization({required ArgResults from}) async {
  try {
    if (from['help'] == true) {
      throw '\x1B[0mAvailable commands :';
    } else {
      final response = await http.post(Uri.parse('https://api.lecto.ai/v1/translate/text'),
          headers: {
            'X-API-Key': '4Z5H0ZS-QHZM2Z8-NTYP640-38D9RFF',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode({
            "texts": ["Just try it mate.", "What are you waiting for?"],
            "to": ["pt-BR", "de"],
            "from": "en"
          }));

      print(jsonDecode(response.body));
    }
  } catch (e) {
    print('\n\x1B[31m$e\x1B[0m\n\n'
        '+---------------+-----------------------------------------------------------------------+\n'
        '| OPTION\t| DESCRIPTION\t\t\t\t\t\t\t\t|\n'
        '+---------------+-----------------------------------------------------------------------+\n'
        '| -i, --input\t| Input directory of where the JSON base translation took place.\t|\n'
        '| \t\t| \x1B[2mdefault to \x1B[0m\x1B[33m"assets/translation/"\x1B[0m\t\t\t\t\t|\n'
        '| -h, --help\t| Print this usage information.\t\t\t\t\t\t|\n'
        '+---------------+-----------------------------------------------------------------------+\n'
        '\nUsage : '
        '\n- \x1B[32mdart\x1B[0m run \x1B[34mdart_fusion\x1B[0m localize -i \x1B[33m"assets/translation/"\x1B[0m');
  }
}
