import 'package:dart_fusion/dart_fusion.dart';
import 'package:example/src/models/immutable_model.dart';
import 'package:example/src/models/mutable_model.dart';

@model
class FirstModel extends ImmutableModel {
  const FirstModel({required super.message, required super.status, required super.model});

  @override
  @variable
  String get message => super.message;
}

@Model(immutable: false)
// ignore: must_be_immutable
class SecondModel extends MutableModel {}