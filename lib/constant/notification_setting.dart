import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Notification settings: use this class and local notification object,
// call the appropriate method to set notification for user
class NotificationPlugin {
  // local notification object
  FlutterLocalNotificationsPlugin _localNotification;

  NotificationPlugin() {
    _initializeNotifications();
  }

  void _initializeNotifications() {
    var androidInitialize =
        new AndroidInitializationSettings('flutter_app_logo');
    var iOSInitialize = new IOSInitializationSettings();
    var initializationSettings =
        new InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    _localNotification = new FlutterLocalNotificationsPlugin();
    _localNotification.initialize(initializationSettings);
  }

  Future showNotification() async {
    var androidDetails = new AndroidNotificationDetails(
        "channelId", "channelName", "channelDescription",
        importance: Importance.high);

    var iOSDetails = new IOSNotificationDetails();
    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails, iOS: iOSDetails);

    await _localNotification.show(0, "Morning Routine",
        "Your Routine Timer Just Finished!", generalNotificationDetails);
  }
}
