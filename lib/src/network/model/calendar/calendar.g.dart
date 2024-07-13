// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MCalendarImpl _$$MCalendarImplFromJson(Map<String, dynamic> json) =>
    _$MCalendarImpl(
      notes: (json['notes'] as List<dynamic>)
          .map((e) => MNote.fromJson(e as Map<String, dynamic>))
          .toList(),
      date: json['date'] as String,
    );

Map<String, dynamic> _$$MCalendarImplToJson(_$MCalendarImpl instance) =>
    <String, dynamic>{
      'notes': instance.notes,
      'date': instance.date,
    };
