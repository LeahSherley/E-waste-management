import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/models/notifications.dart';


final notificationsProvider = Provider<Notifications>((ref) {
  final notifications = Notifications();
  notifications.initializeNotifications();
  return notifications;
});
