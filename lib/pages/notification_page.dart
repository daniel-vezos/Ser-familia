import 'package:app_leitura/widgets/button_notification.dart';
import 'package:flutter/material.dart';

import '../widgets/sub_menu_widget.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Notificações',
          style: TextStyle(color: Colors.black)
        ),
        actions: const [ButtonNotification()],
      ),
      body: const Column(
        children: [
          Divider(
            height: 1,
            color: Color(0xfffb7bac9)
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Você recebeu uma nova tarefa'),
              Text('01/01')
            ],
          ),
          SizedBox(height: 10),
          Divider(
            height: 1,
            color: Color(0xfffb7bac9)
          ),
        ],
      ),
      bottomNavigationBar: const SubMenuDefaultWidget(),
    );
  }
}