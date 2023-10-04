import 'dart:io';

class DProcess {
  const DProcess({
    required this.name,
    required this.arguments,
    required this.help,
  });
  final String name;
  final List<String> arguments;
  final bool help;

  Future<void> run() async {
    try {
      final process = await Process.run(
          'dart',
          [
            'run',
            'dart_fusion',
            name.toLowerCase(),
            if (help) '-h' else ...arguments,
          ],
          workingDirectory: Directory.current.path,
          runInShell: true);
      print('\x1B[33m[$name Runner]\x1B[0m ${process.stdout}${process.stderr}');
    } catch (e) {
      print('\x1B[31m[$name Runner]\x1B[0m $e');
    }
  }
}
