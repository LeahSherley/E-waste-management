import 'package:flutter_local_notifications/flutter_local_notifications.dart';


import 'package:rxdart/subjects.dart';

class Notifications {
  

  final FlutterLocalNotificationsPlugin notificationsplugin =
      FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();
  Future<void> initializeNotifications() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('logo_removebg_preview');
    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await notificationsplugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {
      final payload = notificationResponse.payload;

      onNotifications.add(payload);
    });
  }

  notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channelId',
        'channelName',
        importance: Importance.max,
        playSound: true,
      ),
    );
  }

  Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    String? route,
  }) async {
   

    return notificationsplugin.show(
      id,
      title,
      body,
      await notificationDetails(),
      payload: payload,
    );
  }
}
