import 'dart:async';
import 'package:app_leitura/pages/initial_page.dart';
import 'package:app_leitura/util/secreenutil.dart';
import 'package:app_leitura/widgets/notification_controller.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicialize o Firebase
  await Firebase.initializeApp();

  // Inicialize o Awesome Notifications
  await AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelGroupKey: "basic_channel_group",
        channelKey: "basic_channel",
        channelName: "Basic Notification",
        channelDescription: "Basic notifications channel",
      )
    ],
    channelGroups: [
      NotificationChannelGroup(
        channelGroupKey: "basic_channel_group",
        channelGroupName: "Basic Group",
      )
    ],
  );

  // Verificar permissões e solicitar se necessário
  bool isAllowedToSendNotification =
      await AwesomeNotifications().isNotificationAllowed();
  if (!isAllowedToSendNotification) {
    AwesomeNotifications().requestPermissionToSendNotifications();
  }

  // Agendar notificações para cada minuto
  scheduleNotifications();

  runApp(const MyApp());
}

Future<void> scheduleNotifications() async {
  try {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'basic_channel',
        title: 'Reminder',
        body: 'This is a scheduled notification every minute.',
      ),
      schedule: NotificationInterval(
        interval: 60, // Intervalo de 60 segundos (1 minuto)
        preciseAlarm: true, // Para garantir precisão
      ),
    );
    print('Notification scheduled successfully.');
  } catch (e) {
    print('Failed to schedule notification: $e');
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: InitialPage(), // Altere aqui para a página que você deseja abrir
    );
  }
}
