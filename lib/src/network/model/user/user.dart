import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:safebump/src/config/enum/baby_type_enum.dart';
import 'package:safebump/src/feature/edit_profile/widget/unit_segment.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class MUser extends Equatable with _$MUser {
  const MUser._();
  const factory MUser({
    required String id,
    String? name,
    String? avatar,
    String? email,
    DateTime? dateOfBirth,
    Gender? gender,
    MeasurementUnitType? measurementUnit,
    double? height,
    double? weight,
  }) = _MUser;

  factory MUser.empty() {
    return const MUser(id: '');
  }

  factory MUser.fromJson(Map<String, Object?> json) => _$MUserFromJson(json);

  @override
  List<Object?> get props => [
        id,
        name,
        avatar,
        email,
        dateOfBirth,
        gender,
        measurementUnit,
        height,
        weight
      ];
}
