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
    // Este método é chamado quando o aplicativo está em segundo plano ou fechado.
    // Você pode armazenar o payload aqui, se necessário.
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    print('Handling notification message');

    // Se o aplicativo está em primeiro plano, navegue para NotificationPage.
    if (navigatorKey.currentState?.mounted ?? false) {
      navigatorKey.currentState?.pushNamed(
        NotificationPage.route,
        arguments: message,
      );
    } else {
      print('Navigator is not mounted or not available');
    }
  }

  Future<void> initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // Quando o aplicativo é iniciado a partir de uma notificação
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        handleMessage(message);
      }
    });

    // Quando o usuário abre o aplicativo clicando na notificação
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      handleMessage(message);
    });

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    // Quando a notificação é recebida enquanto o aplicativo está em primeiro plano
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;

      // Exibe a notificação local
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
        payload: jsonEncode(message.toMap()), // Armazena o payload
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
        if (payload.payload != null) {
          final message = RemoteMessage.fromMap(jsonDecode(payload.payload!));
          handleMessage(message);
        }
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
