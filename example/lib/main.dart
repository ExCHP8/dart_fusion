import 'dart:io';

import 'package:dart_fusion/dart_fusion.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DartFusion.runner([
    AssetRunner(
        input: Directory('assets/'), output: File('lib/src/asset.dart')),
    ModelRunner(input: Directory.current),
    LocalizeRunner(
        input: File('assets/translation/en.json'),
        output: File('lib/src/label.dart'))
  ]);
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text('Hello world 🚀'),
      ),
    );
  }
}
