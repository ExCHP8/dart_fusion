part of '../../dart_fusion_flutter.dart';

/// Runner to translate [Locale] and generate a model to be integrated with `easy_localization`.
class LocalizeRunner extends DRunner {
  /// Default constant constructor where the [input] by default is `assets/translation/en.json`,
  /// with default Locale
  /// [from] `en` and targetting list of Locale in [DartFusion.locales].
  const LocalizeRunner(
      {this.input,
      this.output,
      this.from = const Locale('en'),
      this.to = DartFusion.locales,
      this.translate = false,
      this.exclude = const []});

  /// Printing usage information of [LocalizeRunner].
  const LocalizeRunner.help()
      : input = null,
        output = null,
        from = null,
        to = null,
        exclude = null,
        translate = false,
        super.help();

  /// Input json default localization file. By default is `assets/translation/en.json`.
  final File? input;

  /// Output generated model to be integrated with `easy_localization`.
  final File? output;

  /// List of targeted translation. By default its [DartFusion.locales].
  final List<Locale>? to;

  /// List of excluded translation. By default its empty.
  final List<Locale>? exclude;

  /// Base Locale. By default is `Locale('en')`.
  final Locale? from;

  /// Choose whether to translate json to targetted locales or not.
  final bool translate;

  @override
  String get name => 'Localize';

  @override
  List<String> get arguments => [
        if (input != null) ...['-i', input!.path],
        if (output != null) ...['-o', output!.path],
        if (from != null) ...['--from', from!.languageCode],
        if (to != null) ...['--to', to!.map((e) => e.languageCode).join(',')],
        if (exclude != null) ...[
          '--exclude',
          exclude!.map((e) => e.languageCode).join(',')
        ],
        translate ? '--translate' : '--no-translate'
      ];
}
