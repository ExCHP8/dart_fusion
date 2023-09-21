import 'dart:io';

import 'package:dart_fusion/dart_fusion.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DartFusion.initialize([
    const AssetRunner(input: 'assets/', output: 'lib/src/assets.dart'),
    ModelRunner(input: Directory.current.path),
    const LocalizeRunner(
        input: 'assets/translation/en.json',
        output: 'lib/src/localize.dart',
        from: Locale('en'),
        to: DartFusion.locales)
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Text('Hello world 🚀'));
  }
}
