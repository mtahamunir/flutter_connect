

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class notificationApi {
//   static final _notifications = FlutterLocalNotificationsPlugin();
  
//   static Future _notificationsdetails() async {
//     return 
//     NotificationDetails(
//       android: AndroidNotificationDetails('channel Id', 'channel Name',importance: Importance.max)
//     );
//   }


//   static Future showNotification({
//     int id = 0,
//     String? title,
//     String? body,
//     String? payload,
//     required  DateTime scheduleDate
//   }) async => _notifications.zonedSchedule(id,
//    title,
//    body,
//   tz.TZDateTime.from(scheduleDate).tz.local,
//    await _notificationsdetails(),
//   payload: payload, 
//   uiLocalNotificationDateInterpretation: null);
// }