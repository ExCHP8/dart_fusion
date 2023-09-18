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
