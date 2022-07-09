// ignore_for_file: unnecessary_null_comparison

import 'dart:math';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/src/configs/configs.dart';
import 'package:flutter_application_1/src/configs/constants/app_color.dart';
import 'package:flutter_application_1/src/presentations/splash/splash_screen.dart';
import 'package:uuid/uuid.dart';

import 'src/configs/di/injection.dart';

const uuid = Uuid();
var rng = Random();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.dark,
  ));
  await Firebase.initializeApp();

  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        channelDescription: "Notification channel for basic tests",
        defaultColor: Colors.teal,
        importance: NotificationImportance.High,
        channelShowBadge: true,
      ),
    ],
  );

  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance.getToken();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("adakdaka");
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: rng.nextInt(1000000),
          channelKey: 'basic_channel',
          title: message.notification!.title,
          body: message.notification!.body,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouters.generateRoute,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.orange,
          textTheme: const TextTheme().apply(
            bodyColor: AppColors.textcolor,
            displayColor: AppColors.textcolor,
          )),
      home: const SplashScreen(),
    );
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: rng.nextInt(1000000),
      channelKey: 'basic_channel',
      title: message.notification!.title,
      body: message.notification!.body,
    ),
  );
}
