// ignore_for_file: must_be_immutable

import 'package:dart_fusion/dart_fusion.dart';

@Model(immutable: false)
class MutableModel extends DModel {
  @variable
  String message = '';

  @variable
  int status = 200;

  @override
  MutableModel copyWith({
    String? message,
    int? status,
  }) {
    return MutableModel()
      ..message = message ?? this.message
      ..status = status ?? this.status;
  }

  @override
  JSON get toJSON => {
        'message': message,
        'status': status,
        ...super.toJSON,
      };

  static MutableModel fromJSON(JSON value) {
    return MutableModel()
      ..message = value.of<String>('message')
      ..status = value.of<int>('status');
  }
}

@model
class ImmutableModel extends DModel {
  const ImmutableModel({
    required this.message,
    required this.status,
    required this.mutableModel,
  });

  @variable
  final String message;

  @variable
  final int status;

  @Variable(name: 'mutable_model', toJSON: false, fromJSON: true)
  final MutableModel mutableModel;

  @override
  JSON get toJSON => {
        'message': message,
        'status': status,
        'mutable_model': mutableModel,
        ...super.toJSON,
      };

  @override
  ImmutableModel copyWith({
    String? message,
    int? status,
    MutableModel? mutableModel,
  }) {
    return ImmutableModel(
      message: message ?? this.message,
      status: status ?? this.status,
      mutableModel: mutableModel ?? this.mutableModel,
    );
  }

  static ImmutableModel fromJSON(JSON value) {
    return ImmutableModel(
      message: value.of<String>('message'),
      status: value.of<int>('status'),
      mutableModel: MutableModel.fromJSON(value.of<JSON>('mutable_model')),
    );
  }
}
