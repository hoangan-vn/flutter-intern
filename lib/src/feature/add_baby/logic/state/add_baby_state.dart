import 'package:equatable/equatable.dart';
import 'package:safebump/src/config/enum/baby_type_enum.dart';

enum AddBabyScreenStatus { init, saving, fail, success }

class AddBabyState with EquatableMixin {
  AddBabyState(
      {this.type = BabyType.baby,
      this.status = AddBabyScreenStatus.init,
      this.babyName = '',
      this.gender = Gender.male,
      this.birthWeight = 0.0,
      this.birthHeight = 0.0,
      this.birthExperience = '',
      this.babyImage,
      this.errorBabyName,
      this.babyBirthDate,
      this.errorBabyBirthDate,
      this.babyBirthTime,
      this.errorBabyBirthTime,
      this.errorBirthWeight,
      this.errorBirthHeight});

  final BabyType type;
  final AddBabyScreenStatus status;
  final String? babyImage;
  final String babyName;
  final String? errorBabyName;
  final DateTime? babyBirthDate;
  final String? errorBabyBirthDate;
  final DateTime? babyBirthTime;
  final String? errorBabyBirthTime;
  final Gender gender;
  final double birthWeight;
  final String? errorBirthWeight;
  final double birthHeight;
  final String? errorBirthHeight;
  final String birthExperience;

  @override
  List<Object?> get props => [
        type,
        status,
        babyImage,
        babyName,
        errorBabyName,
        babyBirthDate,
        errorBabyBirthDate,
        babyBirthTime,
        errorBabyBirthTime,
        gender,
        birthWeight,
        errorBirthWeight,
        birthHeight,
        errorBirthHeight,
        birthExperience
      ];

  AddBabyState copyWith(
      {BabyType? type,
      AddBabyScreenStatus? status,
      String? babyImage,
      String? babyName,
      String? errorBabyName,
      DateTime? babyBirthDate,
      String? errorBabyBirthDate,
      DateTime? babyBirthTime,
      String? errorBabyBirthTime,
      Gender? gender,
      double? birthWeight,
      String? errorBirthWeight,
      double? birthHeight,
      String? errorBirthHeight,
      String? birthExperience}) {
    return AddBabyState(
        type: type ?? this.type,
        status: status ?? this.status,
        babyImage: babyImage ?? this.babyImage,
        babyName: babyName ?? this.babyName,
        errorBabyName: errorBabyName ?? this.errorBabyName,
        babyBirthDate: babyBirthDate ?? this.babyBirthDate,
        errorBabyBirthDate: errorBabyBirthDate ?? this.errorBabyBirthDate,
        babyBirthTime: babyBirthTime ?? this.babyBirthTime,
        errorBabyBirthTime: errorBabyBirthTime ?? this.errorBabyBirthTime,
        gender: gender ?? this.gender,
        birthWeight: birthWeight ?? this.birthWeight,
        errorBirthWeight: errorBirthWeight ?? this.errorBirthWeight,
        birthHeight: birthHeight ?? this.birthHeight,
        errorBirthHeight: errorBirthHeight ?? this.errorBirthHeight,
        birthExperience: birthExperience ?? this.birthExperience);
  }
}
