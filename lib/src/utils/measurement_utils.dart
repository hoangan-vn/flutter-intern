extension MeasurementExtension on double {
  double toCentimeter() {
    return ((this ~/ 100).toDouble() + (this % 100 / 12)) * 30.48;
  }

  double toFeet() {
    return (this / 3.048 ~/ 10).toDouble() * 100 + (this / 3.048 % 10 * 1.2);
  }

  double toKilogram() {
    return this * 0.45359237;
  }

  double toKilogramToServer() {
    // divide 10 because of smallest division of metric weight is 0.1 kg.
    return this * 0.045359237;
  }

  double toLb() {
    return this / 0.45359237;
  }

  double kgToLb() {
    return this / 0.45359237;
  }

//User for data
  double kgToLbs() {
    return this * 2.2;
  }

  double mToInch() {
    return this * 39.3701;
  }
}
