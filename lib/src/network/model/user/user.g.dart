// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MUserImpl _$$MUserImplFromJson(Map<String, dynamic> json) => _$MUserImpl(
      id: json['id'] as String,
      name: json['name'] as String?,
      avatar: json['avatar'] as String?,
      email: json['email'] as String?,
      dateOfBirth: json['dateOfBirth'] == null
          ? null
          : DateTime.parse(json['dateOfBirth'] as String),
      gender: $enumDecodeNullable(_$GenderEnumMap, json['gender']),
      measurementUnit: $enumDecodeNullable(
          _$MeasurementUnitTypeEnumMap, json['measurementUnit']),
      height: (json['height'] as num?)?.toDouble(),
      weight: (json['weight'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$MUserImplToJson(_$MUserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': instance.avatar,
      'email': instance.email,
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
      'gender': _$GenderEnumMap[instance.gender],
      'measurementUnit': _$MeasurementUnitTypeEnumMap[instance.measurementUnit],
      'height': instance.height,
      'weight': instance.weight,
    };

const _$GenderEnumMap = {
  Gender.male: 'male',
  Gender.female: 'female',
};

const _$MeasurementUnitTypeEnumMap = {
  MeasurementUnitType.imperial: 'imperial',
  MeasurementUnitType.metric: 'metric',
};
