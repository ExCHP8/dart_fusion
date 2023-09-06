// ignore_for_file: avoid_print

import 'dart:io';

import 'package:args/args.dart';

part 'src/asset.dart';
part 'src/pubspec.dart';
part 'src/usage.dart';

Future<void> main(List<String> arguments) async {
  ArgParser scanner = ArgParser()
    ..addOption('input', abbr: 'i', defaultsTo: 'assets/', help: 'Input directory of where assets took place.')
    ..addOption('output', abbr: 'o', defaultsTo: 'lib/src/assets.dart', help: 'Output file of generated asset class')
    ..addFlag('help', abbr: 'h', negatable: false, defaultsTo: false, help: 'Print this usage information');
  ArgParser generator = ArgParser()
    ..addOption('input', abbr: 'i')
    ..addOption('output', abbr: 'o')
    ..addFlag('help', abbr: 'h', negatable: false, defaultsTo: false, help: 'Print this usage information');
  ArgParser runner = ArgParser()
    ..addCommand('asset', scanner)
    ..addCommand('model', generator)
    ..addFlag('help', abbr: 'h', negatable: false, defaultsTo: false, help: 'Print this usage information');
  try {
    ArgResults? argument = runner.parse(arguments).command;
    print(scanner.usageTable);

    if (argument?.name == 'asset') {
      try {
        if (argument?['help'] == true) {
          throw '\u001b[0mAvailable commands :';
        } else {
          insertAsset(from: argument!);
          insertPubspec(from: argument);
        }
      } catch (e) {
        print("\n\u001b[31m$e\u001b[0m\n");
        print('+---------------+-----------------------------------------------+\n'
            '| OPTION\t| DESCRIPTION\t\t\t\t\t|\n'
            '+---------------+-----------------------------------------------+\n'
            '${scanner.usage}\n'
            '+---------------+-----------------------------------------------+\n');
      }
    } else if (argument?.name == 'model') {
      print("Model motherfather");
    } else {
      throw '\u001b[0mAvailable commands :';
    }
  } catch (e) {
    print("\n\u001b[31m$e\u001b[0m\n");
    print('+---------------+-----------------------------------------------+\n'
        '| OPTION\t| DESCRIPTION\t\t\t\t\t|\n'
        '+---------------+-----------------------------------------------+\n'
        '| asset\t\t| Generate asset class from asset directory.\t|\n'
        '| model\t\t| Update model to extends DModel completely.\t|\n'
        '| -h, --help\t| Print this usage information.\t\t\t|\n'
        '+---------------+-----------------------------------------------+\n');
  }
}
