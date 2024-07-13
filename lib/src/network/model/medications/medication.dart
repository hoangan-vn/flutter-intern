import 'package:json_annotation/json_annotation.dart';
import 'package:safebump/src/config/enum/medication_enum.dart';

part 'medication.g.dart';

@JsonSerializable(explicitToJson: true)
class MMedication {
  String id;
  String name;
  DoseType doseType;
  double amount;
  String note;
  ReminderFrequencyEnum frequency;
  List<String> time;

  MMedication(
      {required this.id,
      required this.name,
      required this.doseType,
      required this.amount,
      required this.note,
      required this.frequency,
      required this.time});

  @override
  String toString() {
    return 'MMedication{id=$id, name=$name, doseType=$doseType, amount=$amount, note=$note, frequency=$frequency, time=$time}';
  }

  MMedication copyWith(
      {String? id,
      String? name,
      DoseType? doseType,
      double? amount,
      String? note,
      ReminderFrequencyEnum? frequency,
      List<String>? time}) {
    return MMedication(
        id: id ?? this.id,
        name: name ?? this.name,
        doseType: doseType ?? this.doseType,
        amount: amount ?? this.amount,
        note: note ?? this.note,
        frequency: frequency ?? this.frequency,
        time: time ?? this.time);
  }

  Map<String, dynamic> toJson() => _$MMedicationToJson(this);

  factory MMedication.fromJson(Map<String, dynamic> json) =>
      _$MMedicationFromJson(json);
}
