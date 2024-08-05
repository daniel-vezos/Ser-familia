import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:app_leitura/pages/notification_page.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class NotificationController {
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
    ReceivedNotification receivedNotification,
  ) async {
    // Implementar lógica quando a notificação é criada, se necessário
  }

  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayMethod(
    ReceivedNotification receivedNotification,
  ) async {
    // Implementar lógica quando a notificação é exibida, se necessário
  }

  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
    ReceivedNotification receivedNotification,
  ) async {
    // Implementar lógica quando a notificação é descartada, se necessário
  }

  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
    ReceivedNotification receivedNotification,
  ) async {
    final String? page = receivedNotification.payload?['page'];
    if (page == 'notification_page') {
      // Log para depuração
      print('Notificação clicada, redirecionando para NotificationPage');

      // Use navigatorKey.currentState para navegação
      navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder: (context) => const NotificationPage(
            nameUser:
                'UserName', // Substitua pelo nome real do usuário se disponível
            showMessage: true, // Ajuste conforme necessário
          ),
        ),
      );
    }
  }
}
