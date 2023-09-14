import 'package:dart_fusion/dart_fusion.dart';
import 'package:example/src/mutable_model.dart';

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

  @Variable(toJSON: true, fromJSON: true)
  final MutableModel model;

  @override
  ImmutableModel copyWith({
    String? message,
    int? status,
    MutableModel? model,
  }) {
    return ImmutableModel(
      message: message ?? this.message,
      status: status ?? this.status,
      model: model ?? this.model,
    );
  }

  @override
  JSON get toJSON => {
        'message': message,
        'status': status,
        'model': model.toJSON,
        ...super.toJSON,
      };

  static ImmutableModel fromJSON(JSON value) {
    return ImmutableModel(
      message: value.of<String>('message'),
      status: value.of<int>('status'),
      model: MutableModel.fromJSON(value.of<JSON>('model')),
    );
  }
}
