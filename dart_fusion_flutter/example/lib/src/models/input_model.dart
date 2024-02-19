// ignore_for_file: must_be_immutable

import 'package:dart_fusion/dart_fusion.dart';

enum Test { abc, def, ghi, jkl, mno, pqr, stu, vwx, yz }

@Model(immutable: false)
class MutableModel extends DModel {
  @Variable(defaultsTo: 'Lorem ipsum dolor sit amet')
  String message = '';

  @Variable(defaultsTo: 'THUIS IS AS TEST')
  String? absurd;

  @variable
  int status = 200;

  @Variable(fromJSON: true, toJSON: true)
  List<ImmutableModel> immutables = [];

  Test get enumerate => Test.values[testID];

  @Variable(name: 'test_id')
  int testID = 0;

  @override
  MutableModel copyWith({
    String? message,
    String? absurd,
    int? status,
    List<ImmutableModel>? immutables,
    int? testID,
  }) {
    return MutableModel()
      ..message = message ?? this.message
      ..absurd = absurd ?? this.absurd
      ..status = status ?? this.status
      ..immutables = immutables ?? this.immutables
      ..testID = testID ?? this.testID;
  }

  @override
  JSON get toJSON => {
        'message': message,
        'absurd': absurd,
        'status': status,
        'immutables': immutables.toJSON,
        'test_id': testID,
        ...super.toJSON,
      };

  static MutableModel fromJSON(JSON value) {
    return MutableModel()
      ..message = value.of<String>('message', 'Lorem ipsum dolor sit amet')
      ..absurd = value.of<String?>('absurd') ?? 'THUIS IS AS TEST'
      ..status = value.of<int>('status')
      ..immutables = value
          .of<List<JSON>>('immutables')
          .map(ImmutableModel.fromJSON)
          .toList()
      ..testID = value.of<int>('test_id');
  }

  static MutableModel get test {
    return MutableModel()
      ..message = 'Lorem ipsum dolor sit amet'
      ..absurd = 'THUIS IS AS TEST'
      ..status = 0
      ..immutables = const []
      ..testID = 0;
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

  @Variable(defaultsTo: 'Lorem ipsum dolor sit amet 🚀')
  final String? message;

  @variable
  final int status;

  @Variable(fromJSON: true, toJSON: true)
  final List<MutableModel> mutable;

  @Variable(name: 'mutable_model', toJSON: true, fromJSON: true)
  final MutableModel mutableModel;

  static ImmutableModel get test {
    return ImmutableModel(
      message: 'Lorem ipsum dolor sit amet 🚀',
      status: 0,
      mutable: const [],
      mutableModel: MutableModel.test,
    );
  }

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
        'mutableModel': mutableModel.toJSON,
        ...super.toJSON,
      };

  static ImmutableModel fromJSON(JSON value) {
    return ImmutableModel(
      message: value.of<String?>('message') ?? 'Lorem ipsum dolor sit amet 🚀',
      status: value.of<int>('status'),
      mutable:
          value.of<List<JSON>>('mutable').map(MutableModel.fromJSON).toList(),
      mutableModel: MutableModel.fromJSON(value.of<JSON>('mutableModel')),
    );
  }
}
