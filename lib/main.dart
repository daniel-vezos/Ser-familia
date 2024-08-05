import 'dart:async'; // Adicione esta importação
import 'package:app_leitura/pages/initial_page.dart';
import 'package:app_leitura/widgets/notification_controller.dart';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Inicialize o AwesomeNotifications
  await AwesomeNotifications().initialize(
    null, // Use o nome do ícone conforme configurado no drawable
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

  // Verifica permissões e solicita se necessário
  bool isAllowedToSendNotification =
      await AwesomeNotifications().isNotificationAllowed();
  if (!isAllowedToSendNotification) {
    AwesomeNotifications().requestPermissionToSendNotifications();
  }

  // Inicia o timer para enviar notificações a cada minuto
  startNotificationTimer();

  runApp(const MyApp());
}

void startNotificationTimer() {
  Timer.periodic(const Duration(minutes: 1), (Timer timer) {
    // Cria e envia a notificação
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch ~/
            1000, // Gera um ID único para a notificação
        channelKey: 'basic_channel',
        title: 'Semana Liberada',
        body:
            'A semana seguinte foi liberada! Continue avançando e alcançando seus objetivos!',
        payload: {'page': 'notification_page'},
      ),
    );
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // Configura os ouvintes do AwesomeNotifications
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationController.onActionReceivedMethod,
      onNotificationCreatedMethod:
          NotificationController.onNotificationCreatedMethod,
      onNotificationDisplayedMethod:
          NotificationController.onNotificationDisplayMethod,
      onDismissActionReceivedMethod:
          NotificationController.onDismissActionReceivedMethod,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey, // Adicione esta linha
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const InitialPage(), // A página inicial do seu aplicativo
    );
  }
}
