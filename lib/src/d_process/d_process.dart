class DProcess {
  const DProcess({
    required this.name,
    required this.arguments,
    required this.help,
  });
  final String name;
  final List<String> arguments;
  final bool help;

  Future<void> run() async {}
}
