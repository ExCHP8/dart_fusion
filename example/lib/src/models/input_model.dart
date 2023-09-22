// ignore_for_file: must_be_immutable

import 'package:dart_fusion/dart_fusion.dart';

@Model(immutable: false)
class MutableModel extends DModel {
  @variable
  String message = '';

  @variable
  int status = 200;

  @Variable(fromJSON: true, toJSON: true)
  List<ImmutableModel> immutables = [];

  @override
  MutableModel copyWith({
    String? message,
    int? status,
    List<ImmutableModel>? immutables,
  }) {
    return MutableModel()
      ..message = message ?? this.message
      ..status = status ?? this.status
      ..immutables = immutables ?? this.immutables;
  }

  @override
  JSON get toJSON => {
        'message': message,
        'status': status,
        'immutables': immutables.toJSON,
        ...super.toJSON,
      };

  static MutableModel fromJSON(JSON value) {
    return MutableModel()
      ..message = value.of<String>('message')
      ..status = value.of<int>('status')
      ..immutables = value
          .of<List<JSON>>('immutables')
          .map(ImmutableModel.fromJSON)
          .toList();
  }
}

@model
class ImmutableModel extends DModel {
  const ImmutableModel({
    required this.message,
    required this.status,
    required this.mutableModel,
    required this.mutable,
  });

  @variable
  final String message;

  @variable
  final int status;

  @Variable(fromJSON: true, toJSON: true)
  final List<MutableModel> mutable;

  @Variable(name: 'mutable_model', toJSON: true, fromJSON: true)
  final MutableModel mutableModel;

  @override
  ImmutableModel copyWith({
    String? message,
    int? status,
    List<MutableModel>? mutable,
    MutableModel? mutableModel,
  }) {
    return ImmutableModel(
      message: message ?? this.message,
      status: status ?? this.status,
      mutable: mutable ?? this.mutable,
      mutableModel: mutableModel ?? this.mutableModel,
    );
  }

  @override
  JSON get toJSON => {
        'message': message,
        'status': status,
        'mutable': mutable.toJSON,
        'mutable_model': mutableModel.toJSON,
        ...super.toJSON,
      };

  static ImmutableModel fromJSON(JSON value) {
    return ImmutableModel(
      message: value.of<String>('message'),
      status: value.of<int>('status'),
      mutable:
          value.of<List<JSON>>('mutable').map(MutableModel.fromJSON).toList(),
      mutableModel: MutableModel.fromJSON(value.of<JSON>('mutable_model')),
    );
  }
}
