class BabyFactModel {
  BabyFactModel(
      {required this.fact,
      required this.height,
      required this.weight,
      required this.daysLeft});

  final String fact;
  final int height;
  final int weight;
  final int daysLeft;

  BabyFactModel copyWith(
      {String? fact, int? height, int? weight, int? daysLeft}) {
    return BabyFactModel(
        fact: fact ?? this.fact,
        height: height ?? this.height,
        weight: weight ?? this.weight,
        daysLeft: daysLeft ?? this.daysLeft);
  }
}
