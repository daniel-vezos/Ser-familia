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
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NotificationPage(nameUser: nameUser),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8.0), // ajuste o valor conforme necessário
        decoration: BoxDecoration(
          color: Colors.grey[400],
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.notifications),
      ),
    );
  }
}
