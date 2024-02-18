part of '../../dart_fusion.dart';

/// Link reference used in [ResponseModel] to indicate the relationship of resources.
///
/// ```dart
/// LinkModel(
///   method: HttpMethod.get,
///   description: 'Read User Detail',
///   reference: '/user/123');
/// ```
class LinkModel extends DModel {
  /// Constructs a [LinkModel] with [method], [description] and [reference].
  ///
  /// The [method] parameter specifies the method to interact with the [reference].
  /// The [description] parameter helps explaining the function of the [reference].
  /// The [reference] parameter specifies the reference URL of the model.
  const LinkModel({
    required this.method,
    this.description,
    required this.reference,
  });

  /// The method identifying the link model.
  ///
  /// This [method] property represents on how to interact with the given [reference] link.
  final HttpMethod method;

  /// An optional description text to helps descripting what the [reference] link do.
  final String? description;

  /// Reference URL of this model.
  ///
  /// The [reference] property holds the reference link for this model.
  final String reference;

  static LinkModel fromJSON(JSON value) {
    return LinkModel(
      method: HttpMethod.values.firstWhere(
        (e) => e.name.toUpperCase() == value.of<String>('method').toUpperCase(),
        orElse: () => HttpMethod.options,
      ),
      description: value.of<String?>('description'),
      reference: value.of('reference'),
    );
  }

  @override
  LinkModel copyWith({
    HttpMethod? method,
    String? description,
    String? reference,
  }) {
    return LinkModel(
      method: method ?? this.method,
      description: description ?? this.description,
      reference: reference ?? this.reference,
    );
  }

  @override
  JSON get toJSON {
    return {
      'method': method.name.toUpperCase(),
      if (description != null) 'description': description,
      'reference': reference,
      ...super.toJSON,
    };
  }
}
