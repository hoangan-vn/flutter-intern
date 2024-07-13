import 'package:safebump/src/network/model/common/result.dart';
import 'package:safebump/src/network/model/medications/medication.dart';

abstract class MedicationRepository {
  Future<MResult<MMedication>> addMedication(MMedication medication);
  Future<MResult<bool>> updateMedication(MMedication medication);
  Future<MResult<MMedication>> getMedication(String id);
  Future<MResult<bool>> deleteMedication(MMedication medication);
  Future<MResult<List<MMedication>>> getAllMedications();
}
