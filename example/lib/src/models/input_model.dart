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
		...super.toJSON, 
	};
}

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
	JSON get toJSON => {
		...super.toJSON, 
	};
}
