import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationPage extends StatefulWidget {
  static const route = '/notifications';

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<Map<String, dynamic>> _notifications = [];

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final notificationsJson = prefs.getString('notifications') ?? '[]';
    setState(() {
      _notifications = List<Map<String, dynamic>>.from(jsonDecode(notificationsJson));
    });
    await _markAllAsRead();
    await _updateNotificationCount();
  }

  Future<void> _markAllAsRead() async {
    final prefs = await SharedPreferences.getInstance();
    _notifications = _notifications.map((n) {
      n['read'] = true;
      return n;
    }).toList();
    await prefs.setString('notifications', jsonEncode(_notifications));
  }

  Future<void> _updateNotificationCount() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('notificationCount', 0); // Atualiza o contador para 0
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificações'),
      ),
      body: ListView.builder(
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          final notification = _notifications[index];
          return ListTile(
            title: Text(notification['title'] ?? 'Sem título'),
            subtitle: Text(notification['body'] ?? 'Sem corpo'),
            trailing: Text(notification['timestamp'] ?? ''),
          );
        },
      ),
    );
  }
}
