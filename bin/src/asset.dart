part of '../dart_fusion.dart';

void insertAsset({required ArgResults from}) {
  String inputPath = from['input']!.toString();
  String outputPath = from['output']!.toString();
  Directory inputDirectory = Directory(inputPath);
  print(inputDirectory.listSync());
}
