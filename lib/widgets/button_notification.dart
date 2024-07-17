import 'package:app_leitura/pages/notification_page.dart';
import 'package:flutter/material.dart';

class ButtonNotification extends StatelessWidget {
  final String nameUser;
  const ButtonNotification({
    super.key,
    required this.nameUser,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.notifications),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NotificationPage(nameUser: nameUser),
          ),
        );
      },
    );
  }
}
