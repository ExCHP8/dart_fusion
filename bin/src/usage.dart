part of '../dart_fusion.dart';

extension UsageExtension on ArgParser {
  String get usageTable {
    StringBuffer result = StringBuffer();
    for (String column in usage.split('\n')) {
      for (String row in column.split(RegExp(r'\s{2,}'))) {
        result.write('| $row');
      }
      result.write('object');
    }
    List<String> columns = usage.split('\n');
    List<List<String>> rows = columns.map((e) => e.split(RegExp(r'\s{2,}'))).toList();
    return result.toString();
  }
}
