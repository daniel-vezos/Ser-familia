import 'dart:convert';

import 'package:app_leitura/pages/notification_page.dart';
import 'package:app_leitura/widgets/notification_key.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseApi {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  final AndroidNotificationChannel _androidChannel =
      const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications',
    importance: Importance.high,
  );

  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    print('Title: ${message.notification?.title}');
    print('Body: ${message.notification?.body}');
    print('Payload: ${message.data}');
    // Redirecionar o usuário para a NotificationPage quando o aplicativo estiver em segundo plano
    if (message.data['redirect'] == 'notification_page') {
      // Manter a navegação adequada aqui, se necessário
    }
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    // Navegar para a NotificationPage ao clicar na notificação
    navigatorKey.currentState?.pushNamed(
      NotificationPage.route,
      arguments: message,
    );
  }

  Future<void> initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      // Quando o aplicativo é iniciado a partir de uma notificação
      handleMessage(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      // Quando o aplicativo é aberto a partir de uma notificação
      handleMessage(message);
    });

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;

      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            icon: 'ic_launcher',
          ),
        ),
        payload: jsonEncode(message.toMap()),
      );
    });
  }

  Future<void> initLocalNotifications() async {
    const iOS = DarwinInitializationSettings();
    const android = AndroidInitializationSettings('ic_launcher');
    const settings = InitializationSettings(android: android, iOS: iOS);

    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (payload) {
        final message = RemoteMessage.fromMap(jsonDecode(payload as String));
        handleMessage(message);
      },
    );

    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  Future<String?> getDeviceToken() async {
    return await _firebaseMessaging.getToken();
  }

  Future<void> initNotifications() async {
    await FirebaseMessaging.instance.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print("###### PRINT DEVICE TOKEN TO USE FOR PUSH NOTIFICATION ########");
    print('Token: $fCMToken');
    print("###### PRINT DEVICE TOKEN TO USE FOR PUSH NOTIFICATION ########");

    await initPushNotifications();
    await initLocalNotifications();
  }
}
