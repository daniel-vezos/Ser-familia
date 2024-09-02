import 'dart:convert';
import 'package:app_leitura/pages/notification_page.dart';
import 'package:app_leitura/widgets/notification_key.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

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

  // Lista para armazenar as notificações recebidas
  final List<RemoteMessage> _notifications = [];

  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    // Armazena a notificação recebida em background
    _notifications.add(message);
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    // Adiciona a notificação à lista
    _notifications.add(message);

    // Atualiza a lista de notificações e navega para a página de notificações
    if (navigatorKey.currentState?.mounted ?? false) {
      navigatorKey.currentState?.pushNamed(
        NotificationPage.route,
        arguments: _notifications, // Passa a lista atualizada de notificações
      ).then((_) {
        // Limpa a lista de notificações após visualização
        _notifications.clear();
      });
    } else {
      print('Navigator is not mounted or not available');
    }
  }

  Future<void> initPushNotifications() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

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
        payload: jsonEncode(message.toMap()), // Armazena o payload
      );

      // Adiciona a notificação à lista
      _notifications.add(message);

      // Navega para NotificationPage se o aplicativo estiver aberto
      if (navigatorKey.currentState?.mounted ?? false) {
        navigatorKey.currentState?.pushNamed(
          NotificationPage.route,
          arguments: _notifications, // Passa a lista atualizada de notificações
        ).then((_) {
          // Limpa a lista de notificações após visualização
          _notifications.clear();
        });
      }
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

  // Método para obter a lista de notificações
  List<RemoteMessage> getNotifications() => _notifications;
}
