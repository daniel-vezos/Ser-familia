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

  // Contador de notificações não vistas
  int _unreadNotificationCount = 0;

  // Método para lidar com mensagens em background
  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    // Armazena a notificação recebida em background
    _notifications.add(message);
    _unreadNotificationCount++;
  }

  // Método para lidar com mensagens quando o usuário clica na notificação
  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    // Adiciona a notificação à lista
    _notifications.add(message);
    _unreadNotificationCount++; // Incrementa o contador de notificações não vistas

    // Redireciona apenas quando o usuário clica na notificação
    if (navigatorKey.currentState?.mounted ?? false) {
      navigatorKey.currentState
          ?.pushNamed(
        NotificationPage.route,
        arguments: _notifications, // Passa a lista atualizada de notificações
      )
          .then((_) {
        // Limpa as notificações após visualização
        removeNotificationsAfterViewed(); // Remove notificações visualizadas e zera o contador
      });
    } else {
      print('Navigator is not mounted or not available');
    }
  }

  // Método para inicializar notificações push
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
        payload: jsonEncode(message.toMap()), // Armazena o payload
      );

      // Adiciona a notificação à lista
      _notifications.add(message);
      _unreadNotificationCount++; // Incrementa o contador de notificações não vistas

      print(
          'Notificação recebida em primeiro plano: ${message.notification?.title}');
    });
  }

  // Método para inicializar notificações locais
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

  // Método para obter o token do dispositivo
  Future<String?> getDeviceToken() async {
    return await _firebaseMessaging.getToken();
  }

  // Método para inicializar notificações
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
  List<RemoteMessage> getNotifications() {
    return _notifications;
  }

  // Método para zerar o contador de notificações não vistas
  void clearUnreadNotifications() {
    _unreadNotificationCount = 0;
  }

  // Método para remover notificações visualizadas
  void removeNotificationsAfterViewed() {
    _notifications.clear(); // Limpa todas as notificações após visualização
    clearUnreadNotifications(); // Zera o contador de notificações não vistas
  }

  // Método para obter o contador de notificações não vistas
  int getUnreadNotificationCount() {
    return _unreadNotificationCount;
  }
}
