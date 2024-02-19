import 'package:test/test.dart';
import 'package:dart_fusion/dart_fusion.dart';

void main() {
  group('JSON extension tests', () {
    test('of<int> should return correct value', () {
      final json = {'intValue': '42'};
      expect(json.of<int>('intValue', 10), equals(42));
      expect(json.of<int>('nonExistentKey', 10), equals(10));
      expect(json.of<int>('invalidValue', 10), equals(10));
    });

    test('of<double> should return correct value', () {
      final json = {'doubleValue': '3.14'};
      expect(json.of<double>('doubleValue', 2.5), equals(3.14));
      expect(json.of<double>('nonExistentKey', 2.5), equals(2.5));
      expect(json.of<double>('invalidValue', 2.5), equals(2.5));
    });

    test('of<bool> should return correct value', () {
      final json = {'boolValue': 'true'};
      expect(json.of<bool>('boolValue', false), equals(true));
      expect(json.of<bool>('nonExistentKey', false), equals(false));
      expect(json.of<bool>('invalidValue', false), equals(false));
    });

    test('of<DateTime> should return correct value', () {
      final json = {'dateTimeValue': '2022-02-19T12:34:56Z'};
      final expectedDateTime = DateTime.utc(2022, 2, 19, 12, 34, 56);
      expect(json.of<DateTime>('dateTimeValue', DateTime.now()),
          equals(expectedDateTime));
      expect(json.of<DateTime>('nonExistentKey', DateTime.now()), isNotNull);
      expect(json.of<DateTime>('invalidValue', DateTime.now()), isNotNull);
    });

    test('of<String> should return correct value', () {
      final json = {'stringValue': 'Hello, World!'};
      expect(
          json.of<String>('stringValue', 'Default'), equals('Hello, World!'));
      expect(json.of<String>('nonExistentKey', 'Default'), equals('Default'));
      expect(json.of<String>('invalidValue', 'Default'), equals('Default'));
    });

    test('of<List> should return correct value', () {
      final json = {
        'listValue': [1, 2, 3]
      };
      expect(json.of<List<int>>('listValue', [4, 5, 6]), equals([1, 2, 3]));
      expect(
          json.of<List<int>>('nonExistentKey', [4, 5, 6]), equals([4, 5, 6]));
      expect(json.of<List<int>>('invalidValue', [4, 5, 6]), equals([4, 5, 6]));
    });

    test('of<Map> should return correct value', () {
      final json = {
        'mapValue': {'key': 'value'}
      };
      expect(
          json.of<Map<String, String>>(
              'mapValue', {'defaultKey': 'defaultValue'}),
          equals({'key': 'value'}));
      expect(
          json.of<Map<String, String>>(
              'nonExistentKey', {'defaultKey': 'defaultValue'}),
          equals({'defaultKey': 'defaultValue'}));
      expect(
          json.of<Map<String, String>>(
              'invalidValue', {'defaultKey': 'defaultValue'}),
          equals({'defaultKey': 'defaultValue'}));
    });

    test('Exception handling in of method', () {
      final json = {'invalidValue': 'invalid'};
      expect(json.of<int>('invalidValue', 10), equals(10));
      expect(json.of<double>('invalidValue', 2.5), equals(2.5));
      expect(json.of<bool>('invalidValue', false), equals(false));
      expect(json.of<DateTime>('invalidValue', DateTime.now()), isNotNull);
      expect(json.of<String>('invalidValues', 'Default'), equals('Default'));
      expect(json.of<List<int>>('invalidValue', [4, 5, 6]), equals([4, 5, 6]));
      expect(
          json.of<Map<String, String>>(
              'invalidValue', {'defaultKey': 'defaultValue'}),
          equals({'defaultKey': 'defaultValue'}));
    });
  });
}
