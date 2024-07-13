import 'dart:math';

class StringUtils {
  static bool isNullOrEmpty(String? value) => value == null || value.isEmpty;

  static String createDataWithUnit(
      {required String data, required String unit}) {
    return "$data $unit";
  }

  static String createGenerateRandomText(
      {required int length, bool hasNumber = true}) {
    var r = Random();
    const chars =
        "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890";
    const charsWithOutNumbers =
        "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz";
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => chars.codeUnitAt(
          r.nextInt(hasNumber ? chars.length : charsWithOutNumbers.length),
        ),
      ),
    );
  }
}
