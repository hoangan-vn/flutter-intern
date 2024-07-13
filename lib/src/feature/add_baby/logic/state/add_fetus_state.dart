import 'package:equatable/equatable.dart';
import 'package:safebump/src/config/enum/baby_type_enum.dart';

enum AddFetusScreenStatus { init, saving, fail, success }

class AddFetusState with EquatableMixin {
  AddFetusState({
    this.type = BabyType.fetus,
    this.fetusImage,
    this.errorFetusName,
    this.fetusName = '',
    this.status = AddFetusScreenStatus.init,
    this.fetusDueDate,
    this.errorFetusDueDate,
  });

  final BabyType type;
  final AddFetusScreenStatus status;
  final String? fetusImage;
  final String fetusName;
  final String? errorFetusName;
  final DateTime? fetusDueDate;
  final String? errorFetusDueDate;

  @override
  List<Object?> get props => [
        type,
        fetusImage,
        fetusName,
        fetusDueDate,
        status,
        errorFetusName,
        errorFetusDueDate
      ];
  AddFetusState copyWith({
    BabyType? type,
    String? fetusImage,
    String? fetusName,
    String? errorFetusName,
    AddFetusScreenStatus? status,
    DateTime? fetusDueDate,
    String? errorFetusDueDate,
  }) {
    return AddFetusState(
      type: type ?? this.type,
      fetusImage: fetusImage ?? this.fetusImage,
      fetusName: fetusName ?? this.fetusName,
      status: status ?? this.status,
      fetusDueDate: fetusDueDate ?? this.fetusDueDate,
      errorFetusName: errorFetusName ?? this.errorFetusName,
      errorFetusDueDate: errorFetusDueDate ?? this.errorFetusDueDate,
    );
  }
}
