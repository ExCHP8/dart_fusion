import 'package:test/test.dart';
import 'package:dart_fusion/dart_fusion.dart';

void main() {
  group('JSON extension tests', () {
    test('Parse integer value', () {
      JSON json = {'value': 42};
      JSON json2 = {'value': false, 'new_value': '42'};
      expect(json.of<int>('value'), equals(42));
      expect(json.of<int>('non_value', 10), equals(10));
      expect(json2.of<int>('value'), equals(0));
      expect(json2.of<int>('value', 10), equals(10));
      expect(json.of<int?>('value'), equals(42));
      expect(json.of<int?>('non_value', 42), equals(42));
      expect(json2.of<int?>('value'), isNull);
      expect(json2.of<int?>('new_value'), equals(42));
      expect(json.of<int?>('value'), isA<int?>());
      expect(json.of('value'), isA<int>());
    });

    test('Parse double value', () {
      JSON json = {'value': 3.14};
      JSON json2 = {'value': false, 'new_value': '3.14'};
      expect(json.of<double>('value'), equals(3.14));
      expect(json.of<double>('non_value', 10.0), equals(10.0));
      expect(json2.of<double>('value'), equals(0.0));
      expect(json2.of<double>('value', 10.0), equals(10.0));
      expect(json.of<double?>('value'), equals(3.14));
      expect(json.of<double?>('non_value', 3.14), equals(3.14));
      expect(json2.of<double?>('value'), isNull);
      expect(json2.of<double?>('new_value'), equals(3.14));
      expect(json.of<double?>('value'), isA<double?>());
      expect(json.of('value'), isA<double>());
    });

    test('Parse boolean value', () {
      JSON json = {'value': true};
      JSON json2 = {'value': 69, 'new_value': false};
      expect(json.of<bool>('value'), equals(true));
      expect(json.of<bool>('non_value', false), equals(false));
      expect(json2.of<bool>('value'), equals(false));
      expect(json2.of<bool>('value', true), equals(true));
      expect(json.of<bool?>('value'), equals(true));
      expect(json.of<bool?>('non_value', true), equals(true));
      expect(json2.of<bool?>('value'), isNull);
      expect(json2.of<bool?>('new_value'), equals(false));
      expect(json.of<bool?>('value'), isA<bool?>());
      expect(json.of('value'), isA<bool>());
    });

    test('Parse datetime value', () {
      DateTime date = DateTime.utc(2022, 2, 19, 12, 34, 56);
      JSON json = {'value': date};
      JSON json2 = {'value': false, 'new_value': '$date'};
      expect(json.of<DateTime>('value'), equals(date));
      expect(json.of<DateTime>('non_value', date), equals(date));
      expect(json2.of<DateTime>('value', date), equals(date));
      expect(json.of<DateTime?>('non_value', date), equals(date));
      expect(json.of<DateTime?>('value'), equals(date));
      expect(json2.of<DateTime?>('value'), isNull);
      expect(json2.of<DateTime?>('new_value'), equals(date));
      expect(json.of<DateTime?>('value'), isA<DateTime?>());
      expect(json.of('value'), isA<DateTime>());
    });

    test('Parse string value', () {
      JSON json = {'value': 'Hello, World!'};
      JSON json2 = {'value': false, 'new_value': 'Test'};
      expect(json.of<String>('value'), equals('Hello, World!'));
      expect(json.of<String>('non_value', 'Default'), equals('Default'));
      expect(json2.of<String>('value'), equals('false'));
      expect(json2.of<String>('value', 'Default'), equals('false'));
      expect(json.of<String?>('value'), equals('Hello, World!'));
      expect(json.of<String?>('non_value', 'Default'), equals('Default'));
      expect(json2.of<String?>('non_value'), isNull);
      expect(json2.of<String?>('new_value'), equals('Test'));
      expect(json.of<String?>('value'), isA<String?>());
      expect(json.of('value'), isA<String>());
    });

    test('Parse list value', () {
      final list = [1, 2, 3];
      JSON json = {'value': list};
      JSON json2 = {'value': false, 'new_value': '[]'};
      expect(json.of<List>('value'), equals(list));
      expect(json.of<List>('non_value', list), equals(list));
      expect(json2.of<List>('value'), equals([]));
      expect(json2.of<List>('value', list), equals(list));
      expect(json.of<List<int>>('value'), equals(list));
      expect(json.of<List?>('non_value'), isNull);
      expect(json2.of<List<int>?>('value'), isA<List<int>?>());
      expect(json.of('value'), isA<List>());
      expect(json.of('value'), isA<List<int>>());
    });

    test('Parse map value', () {
      final map = {'key': 'value'};
      JSON json = {'value': map};
      JSON json2 = {'value': false};
      expect(json.of<Map>('value'), equals(map));
      expect(json.of<Map>('non_value', map), equals(map));
      expect(json2.of<Map>('value'), equals({}));
      expect(json2.of<Map?>('value'), isNull);
      expect(json2.of<Map?>('value', map), equals(map));
      expect(json2.of<Map?>('value'), isA<Map?>());
      expect(json.of('value'), isA<Map>());
      expect(json.of('value'), isA<Map<String, String>>());
    });

    test('Parse custom class', () {
      CustomClass custom = const CustomClass(42);
      JSON json = {'value': custom};
      JSON json2 = {'value': false};
      expect(json.of<CustomClass>('value'), equals(custom));
      expect(json.of<CustomClass>('non_value', custom), equals(custom));
      expect(json2.of<CustomClass>('value', custom), equals(custom));
      expect(json2.of<CustomClass?>('value'), isNull);
      expect(json2.of<CustomClass?>('value', custom), equals(custom));
      expect(json.of('value'), isA<CustomClass>());
    });
  });
}

final class CustomClass {
  const CustomClass(this.id);
  final int id;
}
