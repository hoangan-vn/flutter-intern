import 'package:safebump/src/services/firebase_message.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:safebump/src/utils/utils.dart';

class XAlarm {
  static void callback(
      {required int id,
      required String title,
      required String body,
      required DateTime time,
      String? payload}) {
    xLog.e('Alarm $id fired!');

    XFirebaseMessage.I.scheduleNotification(
      id: id,
      title: title,
      body: body,
      payload: payload,
      time: time,
    );
  }

  static void setupAlarm({
    required int id,
    required String title,
    required String body,
    String? payload,
    required DateTime time,
  }) async {
    await AndroidAlarmManager.periodic(
      const Duration(days: 1),
      id,
      () => callback(
          id: id, time: time, title: title, body: body, payload: payload),
      wakeup: true,
      startAt: DateTime.now(),
    );
  }
}
