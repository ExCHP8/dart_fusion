// ignore_for_file: must_be_immutable

import 'package:dart_fusion/dart_fusion.dart';

@model
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