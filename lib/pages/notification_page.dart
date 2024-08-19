import 'package:app_leitura/pages/app_bar_icons.dart';
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
  int _notificationCount = 0; // Inicialmente 0
  RemoteMessage? message;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();

    // Configura o Firebase Messaging
    FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) {
      // Incrementa o contador de notificações quando uma nova notificação chega
      setState(() {
        _notificationCount++;
      });
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage remoteMessage) {
      // Incrementa o contador de notificações quando o aplicativo é aberto a partir de uma notificação
      setState(() {
        _notificationCount++;
      });
    });

    // Caso o aplicativo esteja em background ou fechado e o usuário o abra via notificação
    _firebaseMessaging.getInitialMessage().then((RemoteMessage? remoteMessage) {
      if (remoteMessage != null) {
        setState(() {
          _notificationCount++;
        });
      }
    });
  }

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
        actions: [
          myAppBarIcon(_notificationCount), // Use o widget personalizado aqui
        ],
      ),
      body: Container(
        color: Colors.grey[300],
        child: Column(
          children: [
            Divider(
              height: 1,
              color: Colors.grey[500],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(notificationBody,
                    style: const TextStyle(color: Colors.black)),
              ],
            ),
            const SizedBox(height: 10),
            Divider(
              height: 1,
              color: Colors.grey[500],
            ),
          ],
        ),
      ),
    );
  }
}
