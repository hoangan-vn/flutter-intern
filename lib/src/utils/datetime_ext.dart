import 'package:intl/intl.dart';

enum DurationEnum {
  second,
  minute,
  hour,
  day,
  week,
  month,
  year,
}

extension DateTimeFormat on DateTime {
  /// Formatted date: Jan 17, 2024
  String get toMMMdy => DateFormat("MMM d, y").format(this);

  /// Formatted date: 16 : 09
  String get toHHmm => DateFormat("HH : mm").format(this);

  /// Formatted date: 01/17/2024
  String get toMMDDYYYYFormat => DateFormat('MM/dd/yyyy').format(this);

  /// Formatted date: Jan 2024
  String get toMMMy => DateFormat("MMM y").format(this);

  bool isSameMomentIn({
    DurationEnum sameIn = DurationEnum.second,
    required DateTime otherTime,
  }) {
    bool isTheSameInYear() {
      return year == otherTime.year;
    }

    bool isTheSameInMonth() {
      return year == otherTime.year && month == otherTime.month;
    }

    bool isTheSameInDay() {
      return year == otherTime.year &&
          month == otherTime.month &&
          day == otherTime.day;
    }

    bool isTheSameInHour() {
      return year == otherTime.year &&
          month == otherTime.month &&
          day == otherTime.day &&
          hour == otherTime.hour;
    }

    bool isTheSameInMinute() {
      return year == otherTime.year &&
          month == otherTime.month &&
          day == otherTime.day &&
          hour == otherTime.hour &&
          minute == otherTime.minute;
    }

    bool isTheSameInSecond() {
      return year == otherTime.year &&
          month == otherTime.month &&
          day == otherTime.day &&
          hour == otherTime.hour &&
          minute == otherTime.minute &&
          second == otherTime.second;
    }

    switch (sameIn) {
      case DurationEnum.year:
        return isTheSameInYear();
      case DurationEnum.month:
        return isTheSameInMonth();
      case DurationEnum.day:
        return isTheSameInDay();
      case DurationEnum.hour:
        return isTheSameInHour();
      case DurationEnum.minute:
        return isTheSameInMinute();
      case DurationEnum.second:
        return isTheSameInSecond();
      default:
        return isTheSameInSecond();
    }
  }
}
