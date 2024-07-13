import 'package:safebump/src/network/model/medications/medication.dart';

enum MedicationScreenStatus { init, fetching, fail, success }

class MedicationState {
  MedicationState({
    required this.listMedication,
    this.status = MedicationScreenStatus.init,
  });

  final List<MMedication> listMedication;
  final MedicationScreenStatus status;
  MedicationState copyWith(
      {List<MMedication>? listMedication, MedicationScreenStatus? status}) {
    return MedicationState(
        listMedication: listMedication ?? this.listMedication,
        status: status ?? this.status);
  }
}
