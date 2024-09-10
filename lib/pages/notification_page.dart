import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  static const route = '/notificationpage';

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<RemoteMessage> _notifications = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments is List<RemoteMessage>) {
      setState(() {
        _notifications = arguments;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: const Text(
          'Notificações',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        color: Colors.grey[300],
        child: ListView.builder(
          itemCount: _notifications.length,
          itemBuilder: (context, index) {
            final notification = _notifications[index];
            final notificationBody = notification.notification?.body ??
                'Sem notificações no momento';

            return ListTile(
              title: Text(notification.notification?.title ?? 'Sem título'),
              subtitle: Text(notificationBody),
              trailing: Text(notification.sentTime!.toLocal().toString()),
            );
          },
        ),
      ),
    );
  }
}
