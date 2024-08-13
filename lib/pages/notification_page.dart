import 'package:app_leitura/widgets/button_notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../widgets/sub_menu_widget.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  static const route = '/notificationpage';

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  RemoteMessage? message;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    message = ModalRoute.of(context)?.settings.arguments as RemoteMessage?;
  }

  @override
  Widget build(BuildContext context) {
    final notificationBody =
        message?.notification?.body ?? 'Sem notificações no momento';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: const Text(
          'Notificações',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        color: Colors.grey[300], // Define a cor de fundo da página
        child: Column(
          children: [
            Divider(
              height: 1,
              color: Colors.grey[500], // Ajusta a cor dos divisores
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(notificationBody,
                    style: const TextStyle(
                        color: Colors.black)), // Ajusta a cor do texto
              ],
            ),
            const SizedBox(height: 10),
            Divider(
              height: 1,
              color: Colors.grey[500], // Ajusta a cor dos divisores
            ),
          ],
        ),
      ),
    );
  }
}
