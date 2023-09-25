part of '../../dart_fusion.dart';

/// A class wrapper of `AssetRunner` function.
class Asset {
  /// `AssetRunner` to scan asset and generate model class from it.
  /// Run this command in terminal to use it.
  ///
  /// ```bash
  /// dart run dart_fusion asset
  /// ```
  static void runner({required ArgResults from}) {
    try {
      if (from['help'] == true) {
        throw '\x1B[0mAvailable commands :';
      } else {
        String dir = from['input']!;
        Directory input = Directory(
            dir.endsWith('/') ? dir.substring(0, dir.length - 1) : dir);
        File output = File(from['output']);
        output
          ..parent.createSync(recursive: true)
          ..writeAsStringSync(input.file((dir, file) {
            print(
                '\x1B[32mScanning ${dir.length} directories and ${file.length} files ✔️\x1B[0m \ninto \x1B[33m${output.path} 🚀\x1B[0m');
          }))
          ..createSync(recursive: true);
      }
    } catch (e) {
      print(Asset.information(e));
    }
  }

  /// Usagge information of `AssetRunner`.
  /// Run this command in terminal to print asset usage information.
  ///
  /// ```bash
  /// dart run dart_fusion asset -h
  /// ```
  static String information(dynamic message) {
    return '\n\x1B[31m$message\x1B[0m\n\n'
        '+---------------+-----------------------------------------------+\n'
        '| OPTION\t| DESCRIPTION\t\t\t\t\t|\n'
        '+---------------+-----------------------------------------------+\n'
        '| -i, --input\t| Input directory of where assets took place.\t|\n'
        '| \t\t| \x1B[2mdefault to \x1B[0m\x1B[33m"assets"\x1B[0m\t\t\t\t|\n'
        '| -o, --output\t| Output file of generated asset class.\t\t|\n'
        '| \t\t| \x1B[2mdefault to \x1B[0m\x1B[33m"lib/src/assets.dart"\x1B[0m\t\t|\n'
        '| -h, --help\t| Print this usage information.\t\t\t|\n'
        '+---------------+-----------------------------------------------+\n'
        '\nUsage : '
        '\n- \x1B[32mdart\x1B[0m run \x1B[34mdart_fusion\x1B[0m asset -i \x1B[33m"assets"\x1B[0m -o \x1B[33m"lib/src/assets.dart"\x1B[0m';
  }
}
