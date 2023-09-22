import 'package:dart_fusion/dart_fusion.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DartFusion.runner(const [AssetRunner(), ModelRunner(), LocalizeRunner()]);
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
