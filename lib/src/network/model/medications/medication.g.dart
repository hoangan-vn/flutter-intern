// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medication.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MMedication _$MMedicationFromJson(Map<String, dynamic> json) => MMedication(
      id: json['id'] as String,
      name: json['name'] as String,
      doseType: $enumDecode(_$DoseTypeEnumMap, json['doseType']),
      amount: (json['amount'] as num).toDouble(),
      note: json['note'] as String,
      frequency: $enumDecode(_$ReminderFrequencyEnumEnumMap, json['frequency']),
      time: (json['time'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$MMedicationToJson(MMedication instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'doseType': _$DoseTypeEnumMap[instance.doseType]!,
      'amount': instance.amount,
      'note': instance.note,
      'frequency': _$ReminderFrequencyEnumEnumMap[instance.frequency]!,
      'time': instance.time,
    };

const _$DoseTypeEnumMap = {
  DoseType.application: 'application',
  DoseType.cap: 'cap',
  DoseType.drop: 'drop',
  DoseType.gram: 'gram',
  DoseType.injection: 'injection',
  DoseType.miligram: 'miligram',
  DoseType.mililiter: 'mililiter',
  DoseType.packet: 'packet',
  DoseType.patch: 'patch',
  DoseType.piece: 'piece',
  DoseType.pill: 'pill',
  DoseType.puff: 'puff',
  DoseType.spoon: 'spoon',
  DoseType.spray: 'spray',
  DoseType.suppository: 'suppository',
  DoseType.unit: 'unit',
};

const _$ReminderFrequencyEnumEnumMap = {
  ReminderFrequencyEnum.everyDay: 'everyDay',
};
