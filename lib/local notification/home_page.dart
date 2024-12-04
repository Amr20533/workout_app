// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:workout_app/local%20notification/notifier.dart';
//
// class HomePage extends StatelessWidget {
//    HomePage({Key? key}) : super(key: key);
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =FlutterLocalNotificationsPlugin();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: InkWell(
//           onTap:(){
//             Notifier.initialize(flutterLocalNotificationsPlugin);
//
//             Notifier.showBigTextNotification(title: "New Message title", body: "Your long body", plugin: flutterLocalNotificationsPlugin);
//           },
//           child: Container(
//             width: 200,height: 100,
//             decoration: BoxDecoration(
//               color: Colors.red,
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Text('Click'),
//           ),
//         ),
//       ),
//     );
//   }
// }
