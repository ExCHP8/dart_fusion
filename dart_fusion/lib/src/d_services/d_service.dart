part of '../../dart_fusion.dart';

/// A set of service collection mosty used in dart backend.
class DService {
  /// Generate simple random key identifier
  ///
  /// with [length] by default limit to `6`,
  /// and [characters] default to `ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789`
  static String randomID({
    String characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789',
    int length = 6,
  }) {
    Random random = Random();
    StringBuffer generatedValue = StringBuffer();
    for (var i = 0; i < length; i++) {
      final randomIndex = random.nextInt(characters.length);
      generatedValue.write(characters[randomIndex]);
    }

    return generatedValue.toString();
  }
}
