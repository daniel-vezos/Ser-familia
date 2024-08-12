import 'dart:async';
import 'package:app_leitura/pages/notification_page.dart'; // Verifique o caminho
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class ButtonNotification extends StatefulWidget {
  final String nameUser;

  const ButtonNotification({
    super.key,
    required this.nameUser,
  });

  @override
  _ButtonNotificationState createState() => _ButtonNotificationState();
}

class _ButtonNotificationState extends State<ButtonNotification> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _initializeNotifications(); // Inicialize o Awesome Notifications
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      _showNotification();
    });
  }

  Future<void> _initializeNotifications() async {
    await AwesomeNotifications().initialize(
      'resource://drawable/res_ic_launcher', // Ícone grande do app
      [
        NotificationChannel(
          channelGroupKey: "basic_channel_group",
          channelKey: "basic_channel",
          channelName: "Basic Notification",
          channelDescription: "Basic notifications channel",
          defaultColor: const Color(0xFF9D50DD),
          ledColor: Colors.white,
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
      await AwesomeNotifications().requestPermissionToSendNotifications();
    }
  }

  Future<void> _showNotification() async {
    try {
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 1,
          channelKey: 'basic_channel',
          title: 'Semana Liberadaaa',
          body:
              'A semana seguinte foi liberada! Continue avançando e alcançando seus objetivos!',
          payload: {'page': 'notification_page'},
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

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.notifications),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NotificationPage(
              nameUser: widget.nameUser,
              showMessage: true, // Passe true ou false conforme necessário
            ),
          ),
        );
      },
      color: const Color.fromARGB(255, 8, 8, 8),
      padding: const EdgeInsets.all(8.0),
      splashRadius: 24.0,
    );
  }
}
