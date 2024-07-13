// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MSocialUserImpl _$$MSocialUserImplFromJson(Map<String, dynamic> json) =>
    _$MSocialUserImpl(
      type: $enumDecode(_$MSocialTypeEnumMap, json['type']),
      userID: json['userID'] as String?,
      accessToken: json['accessToken'] as String?,
      idToken: json['idToken'] as String?,
      fullName: json['fullName'] as String?,
      email: json['email'] as String?,
      avatar: json['avatar'] as String?,
      birthDate: json['birthDate'] as String?,
      gender: json['gender'] as int?,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$$MSocialUserImplToJson(_$MSocialUserImpl instance) =>
    <String, dynamic>{
      'type': _$MSocialTypeEnumMap[instance.type]!,
      'userID': instance.userID,
      'accessToken': instance.accessToken,
      'idToken': instance.idToken,
      'fullName': instance.fullName,
      'email': instance.email,
      'avatar': instance.avatar,
      'birthDate': instance.birthDate,
      'gender': instance.gender,
      'phone': instance.phone,
    };

const _$MSocialTypeEnumMap = {
  MSocialType.google: 'google',
  MSocialType.email: 'email',
  MSocialType.apple: 'apple',
};
