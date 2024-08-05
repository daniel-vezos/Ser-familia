import 'package:app_leitura/pages/notification_page.dart';
import 'package:flutter/material.dart';
import 'notification_default.dart'; // Certifique-se de importar o serviço

void showNotification(BuildContext context) {
  final service = NotificationDefault();
  service.showMessage = true;

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => NotificationPage(
        nameUser: 'User Name',
        showMessage: service.showMessage, // Passe um valor bool válido
      ),
    ),
  );
}
