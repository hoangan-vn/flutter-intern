import 'package:flutter_test/flutter_test.dart';
import 'package:safebump/src/utils/datetime_ext.dart';
import 'package:safebump/src/utils/string_ext.dart';

void main() {
  group('Exension Test', () {
    test('get capital text', () {
      expect("hoang An".capitalize(), 'Hoang An');
    });

    test('convert to MMM d, y', () {
      expect(DateTime(2024, 01, 31, 14, 19, 40).toMMMdy, 'Jan 31, 2024');
    });

    test('convert to HH : mm', () {
      expect(DateTime(2024, 01, 31, 14, 19, 40).toHHmm, '14 : 19');
    });

    test('check is same minute with Jan 31, 2024 15:30', () {
      expect(
          DateTime(2024, 01, 31, 14, 19, 40).isSameMomentIn(
              otherTime: DateTime(2024, 01, 31, 15, 30, 40),
              sameIn: DurationEnum.minute),
          false);
    });

    test('check is same day with Jan 31, 2024 15:30', () {
      expect(
          DateTime(2024, 01, 31, 14, 19, 40).isSameMomentIn(
              otherTime: DateTime(2024, 01, 31, 15, 30, 40),
              sameIn: DurationEnum.day),
          true);
    });
  });
}
