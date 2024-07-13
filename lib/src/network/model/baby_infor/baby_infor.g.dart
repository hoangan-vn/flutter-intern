// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'baby_infor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MBabyInfor _$MBabyInforFromJson(Map<String, dynamic> json) => MBabyInfor(
      id: json['id'] as String,
      week: json['week'] as int,
      data: Map<String, String>.from(json['data'] as Map),
      height: (json['height'] as num?)?.toDouble(),
      fact: json['fact'] as String?,
      weight: (json['weight'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$MBabyInforToJson(MBabyInfor instance) =>
    <String, dynamic>{
      'id': instance.id,
      'week': instance.week,
      'height': instance.height,
      'weight': instance.weight,
      'data': instance.data,
      'fact': instance.fact,
    };
