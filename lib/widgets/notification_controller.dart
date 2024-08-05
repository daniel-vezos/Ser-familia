import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:app_leitura/pages/notification_page.dart';

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
      // Navegar para NotificationPage com a mensagem visível
      Navigator.of(navigatorKey.currentContext!).push(
        MaterialPageRoute(
          builder: (context) => const NotificationPage(
            nameUser: 'UserName',
            showMessage:
                true, // Mostrar a mensagem quando a notificação é clicada
          ),
        ),
      );
    }
  }
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
