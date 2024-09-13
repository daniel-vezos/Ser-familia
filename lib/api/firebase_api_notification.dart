import 'dart:convert';
import 'package:app_leitura/pages/notification_page.dart';
import 'package:app_leitura/widgets/notification_key.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  static final FirebaseApi _instance = FirebaseApi._internal();

  factory FirebaseApi() {
    return _instance;
  }

  FirebaseApi._internal();

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
  final List<RemoteMessage> _notifications = [];
  int _unreadNotificationCount = 0;

  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    _notifications.add(message);
    _unreadNotificationCount++;
    print('Mensagem recebida em background: ${message.messageId}');
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    _notifications.add(message);
    _unreadNotificationCount++;
    print('Mensagem recebida ao clicar na notificação: ${message.messageId}');

    if (navigatorKey.currentState?.mounted ?? false) {
      print('Navegando para NotificationPage com argumentos: $_notifications');
      navigatorKey.currentState
          ?.pushNamed(
        NotificationPage.route,
        arguments: List.from(_notifications),
      )
          .then((_) {
        removeNotificationsAfterViewed();
        print('Notificações limpas após visualização.');
      });
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

      _notifications.add(message);
      _unreadNotificationCount++;
      print(
          'Notificação recebida em primeiro plano: ${message.notification?.title}');
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

  Future<void> initNotifications() async {
    await FirebaseMessaging.instance.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print("###### PRINT DEVICE TOKEN TO USE FOR PUSH NOTIFICATION ########");
    print('Token: $fCMToken');
    print("###### PRINT DEVICE TOKEN TO USE FOR PUSH NOTIFICATION ########");

    await initPushNotifications();
    await initLocalNotifications();
  }

  List<RemoteMessage> getNotifications() {
    print('Obtendo notificações: $_notifications');
    return _notifications;
  }

  void clearUnreadNotifications() {
    _unreadNotificationCount = 0;
  }

  void removeNotificationsAfterViewed() {
    _notifications.clear();
    clearUnreadNotifications();
    print('Notificações removidas após visualização.');
  }

  int getUnreadNotificationCount() {
    print('Contador de notificações não vistas: $_unreadNotificationCount');
    return _unreadNotificationCount;
  }
}
