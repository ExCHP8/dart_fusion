import 'package:dart_fusion/dart_fusion.dart';

@Model()
class ImmutableModel extends DModel {
  const ImmutableModel({required this.message, required this.status});

  @variable
  final String message;

  @variable
  final int status;

  @override
	JSON get toJSON => {
		...super.toJSON,
	};
}