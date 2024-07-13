import 'package:flutter_test/flutter_test.dart';
import 'package:safebump/src/utils/datetime_utils.dart';

void main() {
  group('DateTime Format', () {
    test('convertToStartedDay', () {
      expect(
          DateTimeUtils.convertToStartedDay(DateTime(2024, 01, 31, 14, 25, 00)),
          DateTime(2024, 01, 31));
    });

    test('addTimeIntoDate', () {
      expect(
          DateTimeUtils.addTimeIntoDate(
              date: DateTime(2024, 01),
              time: DateTime(2024, 02, 25, 12, 25, 00)),
          DateTime(2024, 01, 01, 12, 25, 00));
    });

    test('fromyMMMd', () {
      expect(
        DateTimeUtils.fromyMMMd("Jan 24, 2024"),
        DateTime(2024, 01, 24),
      );
    });
  });
}
