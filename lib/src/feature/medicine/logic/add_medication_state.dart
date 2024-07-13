import 'package:safebump/src/config/enum/medication_enum.dart';

enum AddMedicationStatus { init, loading, fail, success }

class AddMedicationState {
  AddMedicationState(
      {this.name = '',
      this.doseType = DoseType.unit,
      this.amount = 1,
      this.note = '',
      this.status = AddMedicationStatus.init,
      this.isSetReminder = false,
      this.frequency = ReminderFrequencyEnum.everyDay,
      this.nameError,
      this.timeError,
      this.nameInit,
      this.time});

  final String name;
  final String? nameError;
  final String? nameInit;
  final DoseType doseType;
  final double amount;
  final String note;
  final bool isSetReminder;
  final ReminderFrequencyEnum frequency;
  final AddMedicationStatus status;
  final List<String>? time;
  final String? timeError;
  AddMedicationState copyWith(
      {String? name,
      DoseType? doseType,
      double? amount,
      String? note,
      bool? isSetReminder,
      AddMedicationStatus? status,
      ReminderFrequencyEnum? frequency,
      String? timeError,
      String? nameError,
      String? nameInit,
      List<String>? time}) {
    return AddMedicationState(
      name: name ?? this.name,
      nameError: nameError ?? this.nameError,
      status: status ?? this.status,
      doseType: doseType ?? this.doseType,
      amount: amount ?? this.amount,
      note: note ?? this.note,
      isSetReminder: isSetReminder ?? this.isSetReminder,
      frequency: frequency ?? this.frequency,
      time: time ?? this.time,
      timeError: timeError ?? this.timeError,
      nameInit: nameInit ?? this.nameInit,
    );
  }
}
