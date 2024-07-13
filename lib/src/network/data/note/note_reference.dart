import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safebump/src/network/firebase/base_collection.dart';
import 'package:safebump/src/network/firebase/collection/collection.dart';
import 'package:safebump/src/network/model/calendar/calendar.dart';
import 'package:safebump/src/network/model/common/result.dart';
import 'package:safebump/src/utils/datetime_ext.dart';
import 'package:safebump/src/utils/utils.dart';

class NoteReference extends BaseCollectionReference<MCalendar> {
  NoteReference()
      : super(
          XCollection.calendar,
          getObjectId: (e) => e.date,
          setObjectId: (e, date) => e.copyWith(date: date),
        );

  Future<MResult<MCalendar>> getNote(DateTime date) async {
    try {
      final result = await get(date.toMMMdy);
      return MResult.success(result.data);
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<MCalendar>> upsertNote(MCalendar notes) async {
    try {
      final MResult<MCalendar> result = await set(notes);
      return MResult.success(result.data);
    } catch (e) {
      xLog.e(e);
      return MResult.exception(e);
    }
  }

  Future<MResult<List<MCalendar>>> getNotes() async {
    try {
      final QuerySnapshot<MCalendar> query =
          await ref.get().timeout(const Duration(seconds: 10));
      final docs = query.docs.map((e) => e.data()).toList();
      return MResult.success(docs);
    } catch (e) {
      xLog.e(e);
      return MResult.exception(e);
    }
  }

  Future<MResult<bool>> deleteNote(MCalendar date) async {
    try {
      final result = await get(date.date);
      if (result.isError == true) {
        return MResult.success(false);
      } else {
        final MResult<bool> result = await delete(date);
        xLog.e(result.data);
        return MResult.success(true);
      }
    } catch (e) {
      return MResult.exception(e);
    }
  }
}
