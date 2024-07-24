import 'package:app_leitura/pages/audio_test.dart';
import 'package:app_leitura/widgets/button_notification.dart';
import 'package:app_leitura/widgets/points_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/sub_menu_widget.dart';
import 'page_tasks.dart';

class PageTheme extends StatelessWidget {
  final String nameUser;
  final String weekTitle;
  final List<Map<String, dynamic>> themes;

  const PageTheme(
      {super.key,
      required this.weekTitle,
      required this.themes,
      required this.nameUser});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Center(child: Text('Usuário não autenticado.'));
    }

    List<Widget> themeButtons = themes.map((theme) {
      return Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey[200],
            ),
            child: SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.height *
                  0.9, // 90% da largura da tela
              child: ElevatedButton(
                onPressed: () {
                  final title = theme['title'] ?? 'Sem Título';
                  final challenge = theme['challenge'] ?? 'Sem Descrição';
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PageTasks(
                        title: title,
                        challenge: challenge,
                        nameUser: '',
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.grey[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Center(
                  child: Text(
                    theme['title'] ?? 'Sem Título',
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
        ],
      );
    }).toList();

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          PointsCard(userId: user.uid),
          const SizedBox(width: 16),
          ButtonNotification(nameUser: nameUser),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                 Text(
                  "Olá ${nameUser.split(' ')[0]}",
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              weekTitle,
              style: const TextStyle(fontSize: 24, color: Colors.black),
            ),
            const SizedBox(height: 20),
            Column(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: themeButtons,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: SubMenuWidget(nameUser: nameUser),
    );
  }
}
