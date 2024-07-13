// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MNote _$MNoteFromJson(Map<String, dynamic> json) => MNote(
      title: json['title'] as String,
      type: json['type'] as String,
      detail: json['detail'] as String?,
      hospital: json['hospital'] as String?,
      medicine: json['medicine'] as String?,
      time:
          json['time'] == null ? null : DateTime.parse(json['time'] as String),
      id: json['id'] as String,
      remindTime: json['remindTime'] == null
          ? null
          : DateTime.parse(json['remindTime'] as String),
    );

Map<String, dynamic> _$MNoteToJson(MNote instance) => <String, dynamic>{
      'title': instance.title,
      'id': instance.id,
      'detail': instance.detail,
      'hospital': instance.hospital,
      'type': instance.type,
      'medicine': instance.medicine,
      'time': instance.time?.toIso8601String(),
      'remindTime': instance.remindTime?.toIso8601String(),
    };
