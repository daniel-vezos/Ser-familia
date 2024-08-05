import 'package:app_leitura/pages/notification_page.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class ButtonNotification extends StatelessWidget {
  final String nameUser;
  const ButtonNotification({
    super.key,
    required this.nameUser,
  });

  Future<void> _handleNotification(BuildContext context) async {
    // Navega para NotificationPage
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NotificationPage(nameUser: nameUser),
      ),
    );

    // Adiciona um pequeno delay para garantir que a primeira navegação ocorra
    await Future.delayed(const Duration(milliseconds: 300));

    // Cria e exibe a notificação
   AwesomeNotifications().createNotification(
  content: NotificationContent(
    id: 1,
    channelKey: "basic_channel",
    title: 'Notification Title',
    body: 'Notification Body',
    // Configure a ação de notificação com um payload
    payload: {'page': 'notification_page'},
  ),
);

  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.notifications),
      onPressed: () => _handleNotification(context),
      color: const Color.fromARGB(255, 8, 8, 8),
      padding: const EdgeInsets.all(8.0),
      splashRadius: 24.0,
    );
  }
}
