import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safebump/src/localization/localization_utils.dart';
import 'package:safebump/src/network/firebase/base_collection.dart';
import 'package:safebump/src/network/firebase/collection/collection.dart';
import 'package:safebump/src/network/model/common/result.dart';
import 'package:safebump/src/network/model/medications/medication.dart';
import 'package:safebump/src/utils/utils.dart';

class MedicationReference extends BaseCollectionReference<MMedication> {
  MedicationReference()
      : super(
          XCollection.medications,
          getObjectId: (e) => e.id,
          setObjectId: (e, id) => e.copyWith(id: id),
        );

  Future<MResult<MMedication>> getMedication(String id) async {
    try {
      final result = await get(id);
      if (result.isError == false) {
        return result;
      } else {
        return MResult.error(S.text.someThingWentWrong);
      }
    } catch (e) {
      xLog.e(e);
      return MResult.exception(e);
    }
  }

  Future<MResult<bool>> deleteMedication(MMedication medication) async {
    try {
      final result = await get(medication.id);
      if (result.data == null) {
        return MResult.exception(false);
      } else {
        await delete(medication);
        return MResult.success(true);
      }
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<bool>> updateMedication(MMedication medication) async {
    try {
      final result = await update(medication.id, medication.toJson());
      if (result.isError == true) {
        return MResult.success(false);
      } else {
        return MResult.success(true);
      }
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<MMedication>> getOrAddMedication(
      MMedication medication) async {
    try {
      final result = await get(medication.id);
      if (result.isError == false) {
        return result;
      } else {
        final MResult<MMedication> result = await set(medication);
        return MResult.success(result.data);
      }
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<List<MMedication>>> getAllMedications() async {
    try {
      final QuerySnapshot<MMedication> query =
          await ref.get().timeout(const Duration(seconds: 10));
      final docs = query.docs.map((e) => e.data()).toList();
      return MResult.success(docs);
    } catch (e) {
      return MResult.exception(e);
    }
  }
}
