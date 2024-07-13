// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'baby.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MBabyImpl _$$MBabyImplFromJson(Map<String, dynamic> json) => _$MBabyImpl(
      id: json['id'] as String,
      name: json['name'] as String?,
      avatar: json['avatar'] as String?,
      type: json['type'] as String?,
      gender: json['gender'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      weight: (json['weight'] as num?)?.toDouble(),
      height: (json['height'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$MBabyImplToJson(_$MBabyImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': instance.avatar,
      'type': instance.type,
      'gender': instance.gender,
      'date': instance.date?.toIso8601String(),
      'weight': instance.weight,
      'height': instance.height,
    };
