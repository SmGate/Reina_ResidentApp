import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_notification_channel/flutter_notification_channel.dart';
import 'package:flutter_notification_channel/notification_importance.dart';
import 'package:flutter_notification_channel/notification_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:userapp/Routes/routes_management.dart';
import 'package:userapp/Routes/set_routes.dart';
import 'package:userapp/utils/Constants/secrets.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.notification!.title}");
  print("Handling a background message: ${message.notification!.body}");
}

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isIOS) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: Secrets.API_KEY,
            appId: Secrets.APP_ID,
            messagingSenderId: Secrets.MESSAGING_SENDER_ID,
            projectId: Secrets.PROJECT_ID));
  } else {
    await Firebase.initializeApp();
  }

  var result = await FlutterNotificationChannel.registerNotificationChannel(
    description: 'Your channel description',
    id: 'high_importance_channel',
    importance: NotificationImportance.IMPORTANCE_HIGH,
    name: 'Popup Notification',
    visibility: NotificationVisibility.VISIBILITY_PUBLIC,
  );
  print(result);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ScreenUtilInit(
        useInheritedMediaQuery: true,
        designSize: Size(375, 812),
        builder: (context, child) {
          return GetMaterialApp(
            title: 'Smart Gate',
            debugShowCheckedModeBanner: false,
            initialRoute: splashscreen,
            getPages: RouteManagement.getPages(),
          );
        });
  }
}
