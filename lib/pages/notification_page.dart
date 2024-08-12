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
    final notificationBody = message?.notification?.body ?? 'Sem notificações no momento';

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notificações',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          const Divider(
            height: 1,
            color: Color(0xfffb7bac9),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(notificationBody),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(
            height: 1,
            color: Color(0xfffb7bac9),
          ),
        ],
      ),
    );
  }
}
