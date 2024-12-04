// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// class Notifier{
//   static Future initialize(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async{
//       var andriodInitaialize =new AndroidInitializationSettings('mipmap-hdpi/ic_launcher');
//      // var iosInitaialize =IOSInitializationSettings();
//       var initializeSettings = new InitializationSettings(android: andriodInitaialize ,
//      );
//       await flutterLocalNotificationsPlugin.initialize(initializeSettings);}
//
//   static Future showBigTextNotification({var id = 0,required String title,required String body,var payload,required,required FlutterLocalNotificationsPlugin plugin}) async{
//     AndroidNotificationDetails notificationDetails = AndroidNotificationDetails('You can name it whatever1', 'channel_name',
//     playSound: true,
//       sound: RawResourceAndroidNotificationSound('notification'),
//       importance: Importance.max,
//       priority:  Priority.high,
//     );
//
//     var notification = NotificationDetails(android: notificationDetails,);
//     await plugin.show(0, title, body, notification);
//   }
// }