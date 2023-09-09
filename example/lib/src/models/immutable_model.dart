import 'package:dart_fusion/dart_fusion.dart';
import 'package:example/src/models/mutable_model.dart';

@model
class ImmutableModel extends DModel {
  const ImmutableModel({
    required this.message,
    required this.status,
    required this.model,
  });

  @variable
  final String message;

  @variable
  final int status;

  @Variable(toJSON: true)
  final MutableModel model;

  @override
  JSON get toJSON => {
        ...super.toJSON,
      };
}