part of '../../dart_fusion.dart';

/// Basic model in root of every `Response`, containing [success] status,
/// [message] and also [data] that extends [DModel] class.
///
/// ```dart
/// ResponseModel(
///   success: true,
///   message: 'Successfully Fetching Data!',
///   data: const ResponseDataModel());
/// ```
class ResponseModel extends DModel {
  /// Default constructor of [ResponseModel] with value [success] is `false`,
  /// [message] is `No Message`, and [data] is [DModel].
  const ResponseModel({
    this.success = false,
    this.message = 'No Message',
    this.data,
    this.links = const [],
  });

  static ResponseModel fromJSON<T extends DModel>(JSON value) {
    return ResponseModel(
      success: value.of('success'),
      message: value.of('message'),
      data: value.of('data'),
      links: value.of<List<JSON>>('links').map(LinkModel.fromJSON).toList(),
    );
  }

  /// Success status of whether the response is what is expected or not.
  final bool success;

  /// A short description of Response [success] status.
  final String message;

  /// Child data of [ResponseModel], must be a class that extends
  /// [DModel].
  final JSON? data;

  /// List of reference link of this model.
  final List<LinkModel> links;

  @override
  ResponseModel copyWith({
    bool? success,
    String? message,
    JSON? data,
    List<LinkModel>? links,
  }) {
    return ResponseModel(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
      links: links ?? this.links,
    );
  }

  @override
  JSON get toJSON => {
        'success': success,
        'message': message,
        if (data != null) 'data': data!.toJSON,
        if (links.isNotEmpty) 'links': links.toJSON,
        ...super.toJSON,
      };
}
