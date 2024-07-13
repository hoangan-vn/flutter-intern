import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz_init;
import 'package:timezone/timezone.dart' as tz;

import '../utils/utils.dart';

class XFirebaseMessage {
  factory XFirebaseMessage() => instance;
  XFirebaseMessage._internal();

  static final XFirebaseMessage instance = XFirebaseMessage._internal();
  static XFirebaseMessage get I => instance;

  String? currentToken;
  late Stream<String> _tokenStream;

  late FirebaseMessaging messaging;

  bool isNotificationsInitialized = false;

  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for importance notification',
    importance: Importance.defaultImportance,
  );

  final _localNoti = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    messaging = FirebaseMessaging.instance;
    _tokenStream = messaging.onTokenRefresh;

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await setupNotification();

    registerTokenFCM();

    // NOTE: Request Permission doesn't necessarily implemented here.
    // You should follow the workflow of your project
    await requestPermission();
  }

  @pragma('vm:entry-point')
  void notificationTapBackground(NotificationResponse notificationResponse) {
    xLog.e(notificationResponse.toString());
  }

  Future initLocalNotification() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iOS = DarwinInitializationSettings();
    const settings = InitializationSettings(android: android, iOS: iOS);

    await _localNoti.initialize(
      settings,
      onDidReceiveNotificationResponse: (details) {
        xLog.e(details.payload);
      },
    );

    final platform = _localNoti.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    await platform?.requestNotificationsPermission();

    await platform?.createNotificationChannel(_androidChannel);
  }

  // NOTE: This function you must initialize Plugin Notification. For example:
  // - Awesome Notification:
  //  https://pub.dev/packages/awesome_notifications#-how-to-show-local-notifications
  // - Flutter Local Notification:
  //  https://firebase.flutter.dev/docs/messaging/notifications#foreground-notifications
  //
  //
  // NOTE: To set up for IOS, you can find the documentation
  // at https://firebase.flutter.dev/docs/messaging/apple-integration
  Future<void> setupNotification() async {
    if (isNotificationsInitialized) {
      xLog.e(true);
      return;
    }

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
    initLocalNotification();
    configForegroundNotification();
    configOnMessageOpenApp();
    isNotificationsInitialized = true;
  }

  Future<void> requestPermission() async {
    try {
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      xLog.i('User granted permission: ${settings.authorizationStatus}');
    } catch (e) {
      xLog.e(e);
    }
  }

  void configForegroundNotification() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        showLocalNotification(message);
      }
    });
  }

  Future<void> configOnMessageOpenApp() async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      xLog.i("onMessageOpenedApp: ${json.encode(message.data)}");
    });
  }

  @pragma('vm:entry-point')
  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp();
    await XFirebaseMessage().setupNotification();

    XFirebaseMessage().showLocalNotification(message);
  }

  Future<void> showLocalNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      _localNoti.show(notification.hashCode, notification.title,
          notification.body, getNotificationDetail(),
          payload: jsonEncode(message.toMap()));
    }
  }

  NotificationDetails getNotificationDetail() {
    return NotificationDetails(
        android: AndroidNotificationDetails(
            _androidChannel.id, _androidChannel.name,
            channelDescription: _androidChannel.description,
            icon: '@mipmap/ic_launcher'));
  }

  Future scheduleNotification(
      {int id = 0,
      String? title,
      String? body,
      String? payload,
      required DateTime time}) async {
    tz_init.initializeTimeZones();
    return _localNoti.zonedSchedule(
      id,
      title,
      body,
      nextInstanceRemindTime(time),
      getNotificationDetail(),
      payload: payload,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  Future reminderNotification(
      {int id = 0,
      String? title,
      String? body,
      String? payload,
      required RepeatInterval interval}) async {
    return _localNoti.periodicallyShow(
      id,
      title,
      body,
      interval,
      getNotificationDetail(),
      payload: payload,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  void registerTokenFCM() async {
    // If you want to get a token from the web, you can find the documentation
    // at https://firebase.flutter.dev/docs/messaging/usage/#web-tokens
    messaging.getToken().then((setToken)).onError((error, stackTrace) {
      xLog.e(error);
    });

    _tokenStream.listen(setToken);
  }

  Future<void> unregisterTokenFCM() async {
    await messaging.deleteToken().catchError((error) {
      xLog.e(error);
    });
  }

  void setToken(String? token) {
    xLog.i('FCM Token: $token');
    if (token != null) {
      currentToken = token;
    }
  }

  Future<void> subscribeTopics(String topic) async {
    await messaging.subscribeToTopic(topic);
  }

  Future<void> unSubscribeTopics(String topic) async {
    await messaging.unsubscribeFromTopic(topic);
  }

  tz.TZDateTime nextInstanceRemindTime(DateTime time) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
        tz.local, now.year, now.month, now.day, time.hour, time.minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }
}
