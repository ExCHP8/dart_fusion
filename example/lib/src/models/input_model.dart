// ignore_for_file: must_be_immutable

import 'package:dart_fusion/dart_fusion.dart';

@Model(immutable: false)
class MutableModel extends DModel {
  @variable
  String message = '';

  @variable
  int status = 200;

  @override
	JSON get toJSON => {
		'message': message, 
		'status': status, 
		...super.toJSON, 
	};

	static MutableModel fromJSON(JSON value) {
		return MutableModel()
			..message= value.of<String>('message')
			..status= value.of<int>('status');
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

  @Variable(toJSON: true, fromJSON: true)
  final MutableModel mutableModel;

  @override
	JSON get toJSON => {
		'message': message, 
		'status': status, 
		'mutableModel': mutableModel.toJSON, 
		...super.toJSON, 
	};

	static ImmutableModel fromJSON(JSON value) {
		return ImmutableModel(
			message: value.of<String>('message'),
			status: value.of<int>('status'),
			mutableModel: MutableModel.fromJSON(value.of<JSON>('mutableModel')),
		);
	}
}
