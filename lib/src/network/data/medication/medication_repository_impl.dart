import 'package:safebump/src/network/data/medication/medication_reference.dart';
import 'package:safebump/src/network/data/medication/medication_repository.dart';
import 'package:safebump/src/network/model/common/result.dart';
import 'package:safebump/src/network/model/medications/medication.dart';

class MedicationRepositoryImpl extends MedicationRepository {
  final medicationRef = MedicationReference();

  @override
  Future<MResult<MMedication>> addMedication(MMedication medication) async {
    return await medicationRef.getOrAddMedication(medication);
  }

  @override
  Future<MResult<bool>> updateMedication(MMedication medication) async {
    return await medicationRef.updateMedication(medication);
  }

  @override
  Future<MResult<MMedication>> getMedication(String id) async {
    return await medicationRef.getMedication(id);
  }

  @override
  Future<MResult<bool>> deleteMedication(MMedication medication) async {
    return await medicationRef.deleteMedication(medication);
  }

  @override
  Future<MResult<List<MMedication>>> getAllMedications() async {
    return await medicationRef.getAllMedications();
  }
}
