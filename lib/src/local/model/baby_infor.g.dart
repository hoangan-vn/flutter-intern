// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'baby_infor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BabyInforModel _$BabyInforModelFromJson(Map<String, dynamic> json) =>
    BabyInforModel(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      date: DateTime.parse(json['date'] as String),
      height: (json['height'] as num?)?.toDouble(),
      gender: json['gender'] as String?,
      weight: (json['weight'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$BabyInforModelToJson(BabyInforModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'date': instance.date.toIso8601String(),
      'gender': instance.gender,
      'weight': instance.weight,
      'height': instance.height,
    };
