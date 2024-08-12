import 'dart:async';
import 'package:app_leitura/api/firebase_api_notification.dart';
import 'package:app_leitura/pages/initial_page.dart';
import 'package:app_leitura/widgets/notification_key.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:app_leitura/pages/notification_page.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> backgroundMessageHandler(RemoteMessage message) async {
  // You can also handle background messages here if needed
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Payload: ${message.data}');

  navigatorKey.currentState?.pushNamed(
    NotificationPage.route,
    arguments: message,
  );
}

final navigationKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicialize o Firebase
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);

  await FirebaseApi().initNotifications();

      runApp(const MyApp());
    }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ser Familia',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorKey: navigationKey,
      home: const InitialPage(),
      routes: {
        NotificationPage.route: (context) => const NotificationPage()
      },
    );
  }
}
