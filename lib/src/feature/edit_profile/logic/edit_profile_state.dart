import 'dart:typed_data';

import 'package:safebump/src/config/enum/baby_type_enum.dart';
import 'package:safebump/src/feature/edit_profile/widget/unit_segment.dart';
import 'package:safebump/src/network/model/user/user.dart';

enum EditProfileStatus { init, loading, fail, success }

class EditProfileState {
  EditProfileState(
      {required this.user,
      this.status = EditProfileStatus.init,
      this.name,
      this.initName,
      this.errorName,
      this.email,
      this.dateOfBirth,
      this.gender = Gender.female,
      this.measurementUnit = MeasurementUnitType.metric,
      this.height,
      this.avatar,
      this.weight});

  final String? name;
  final String? errorName;
  final String? email;
  final DateTime? dateOfBirth;
  final Gender? gender;
  final MeasurementUnitType? measurementUnit;
  final MUser user;
  final double? height;
  final double? weight;
  final Uint8List? avatar;
  final String? initName;
  final EditProfileStatus status;
  EditProfileState copyWith(
      {String? name,
      String? errorName,
      String? email,
      DateTime? dateOfBirth,
      Gender? gender,
      MeasurementUnitType? measurementUnit,
      MUser? user,
      double? height,
      double? weight,
      Uint8List? avatar,
      String? initName,
      EditProfileStatus? status}) {
    return EditProfileState(
        name: name ?? this.name,
        initName: initName ?? this.initName,
        errorName: errorName ?? this.errorName,
        email: email ?? this.email,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        gender: gender ?? this.gender,
        measurementUnit: measurementUnit ?? this.measurementUnit,
        user: user ?? this.user,
        height: height ?? this.height,
        weight: weight ?? this.weight,
        avatar: avatar ?? this.avatar,
        status: status ?? this.status);
  }
}
