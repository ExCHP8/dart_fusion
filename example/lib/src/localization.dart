// Dart Fusion Auto-Generated Easy Localization
// Created at 2023-09-21 15:43:26.966287
// 🍔 [Buy me a coffee](https://www.buymeacoffee.com/nialixus) 🚀
// ignore_for_file: constant_identifier_names, non_constant_identifier_names
import 'package:easy_localization/easy_localization.dart';

/// Root class of generated localization. This consist of 6 value
///
/// ```dart
/// String value = Localization.value;
/// ```
class Localization {
  /// Default constant constructor of [Localization]
  ///
  /// ```dart
  /// Localization localization = const Localization();
  /// ```
  const Localization();

  /// String value of `key`.
  ///
  /// ```dart
  /// String key = Localization.key
  /// print(key); // This is a wonderful day!
  /// ```
  static String key = 'key'.tr();

  /// Branch value of [Nested]
  ///
  /// ```dart
  /// Nested nested = Localization.nested
  /// ```
  static Nested nested = const Nested();

  /// String value of `interpolated`.
  ///
  /// ```dart
  /// String interpolated = Localization.interpolated( name: 'name',);
  /// print(interpolated); // Have a nice day, {name}!
  /// ```
  static String interpolated({
    required String name,
  }) =>
      'interpolated'.tr(namedArgs: {
        'name': name,
      });

  /// String value of `pluralKey_one`.
  ///
  /// ```dart
  /// String pluralkey_one = Localization.pluralKey_one
  /// print(pluralkey_one); // This is a nice example.
  /// ```
  static String pluralkey_one = 'pluralKey_one'.tr();

  /// String value of `pluralKey_other`.
  ///
  /// ```dart
  /// String pluralkey_other = Localization.pluralKey_other
  /// print(pluralkey_other); // This are nice examples.
  /// ```
  static String pluralkey_other = 'pluralKey_other'.tr();

  /// String value of `testing`.
  ///
  /// ```dart
  /// String testing = Localization.testing
  /// print(testing); // this is a test
  /// ```
  static String testing = 'testing'.tr();
}

/// Branch class of generated localization. This consist of 2 value
///
/// ```dart
/// String value = Localization.nested.value;
/// ```
class Nested {
  /// Default constant constructor of [Nested]
  ///
  /// ```dart
  /// Nested nested = const Nested();
  /// ```
  const Nested();

  /// String value of `key`.
  ///
  /// ```dart
  /// String key = Localization.nested.key
  /// print(key); // How are you?
  /// ```
  String get key => 'nested.key'.tr();

  /// Branch value of [AnotherNested]
  ///
  /// ```dart
  /// AnotherNested another_nested = Localization.nested.another_nested
  /// ```
  AnotherNested get another_nested => const AnotherNested();
}

/// Branch class of generated localization. This consist of 2 value
///
/// ```dart
/// String value = Localization.nested.another_nested.value;
/// ```
class AnotherNested {
  /// Default constant constructor of [AnotherNested]
  ///
  /// ```dart
  /// AnotherNested anothernested = const AnotherNested();
  /// ```
  const AnotherNested();

  /// String value of `key`.
  ///
  /// ```dart
  /// String key = Localization.nested.another_nested.key
  /// print(key); // Just testing
  /// ```
  String get key => 'nested.another_nested.key'.tr();

  /// String value of `test`.
  ///
  /// ```dart
  /// String test = Localization.nested.another_nested.test( test: 'test', day: 'day',);
  /// print(test); // {test} testing {test} jack {day}
  /// ```
  String test({
    required String test,
    required String day,
  }) =>
      'nested.another_nested.test'.tr(namedArgs: {
        'test': test,
        'day': day,
      });
}
