import 'dart:async';
import 'package:app_leitura/pages/initial_page.dart';
import 'package:app_leitura/widgets/notification_controller.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicialize o Firebase
  await Firebase.initializeApp();

  // Inicialize o Firebase Cloud Messaging
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Obtenha e imprima o token de registro FCM
  String? token = await messaging.getToken();
  print('FCM Token: $token');

  // Configuração de notificações, se necessário
  await requestNotificationPermission();

  try {
    await AwesomeNotifications().initialize(
      'resource://drawable/res_app_icon',
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: const Color(0xFF9D50DD),
          ledColor: Colors.white,
          importance: NotificationImportance.High,
          playSound: true,
          enableLights: true,
          enableVibration: true,
        )
      ],
    );
    print('AwesomeNotifications initialized successfully.');
  } catch (e) {
    print('Failed to initialize AwesomeNotifications: $e');
  }

  try {
    bool isAllowedToSendNotification =
        await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowedToSendNotification) {
      await AwesomeNotifications().requestPermissionToSendNotifications();
    }
    print('Notification permission status checked.');
  } catch (e) {
    print('Failed to check or request notification permissions: $e');
  }

  runApp(const MyApp());
}

Future<void> requestNotificationPermission() async {
  try {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true);
    print('Notification permission granted: ${settings.authorizationStatus}');
  } catch (e) {
    print('Failed to request notification permission: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const InitialPage(),
    );
  }
}
