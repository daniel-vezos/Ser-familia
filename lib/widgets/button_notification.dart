import 'package:app_leitura/pages/notification_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ButtonNotification extends StatefulWidget {
  const ButtonNotification({super.key});

  @override
  State<ButtonNotification> createState() => _ButtonNotificationState();
}

class _ButtonNotificationState extends State<ButtonNotification> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.notifications),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const NotificationPage(),
          ),
        );
      },
    );
  }
}