import 'package:app_leitura/widgets/button_notification.dart';
import 'package:flutter/material.dart';
import '../widgets/sub_menu_widget.dart';
import 'page_tasks.dart';

class PageTheme extends StatelessWidget {
  final String weekTitle;
  final List<Map<String, dynamic>> themes;

  const PageTheme({super.key, required this.weekTitle, required this.themes});

  @override
  Widget build(BuildContext context) {
    List<Widget> themeButtons = themes.map((theme) {
      return Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: SizedBox(
              height: 60,
              width: double.infinity,
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
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black, backgroundColor: Colors.white, shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Match the Container borderRadius
                  ), // Text color
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/backgrounds/botao1.png',
                      height: 35,
                      width: 100,
                    ),
                    Expanded(
                      child: Text(
                        theme['title'] ?? 'Sem Título',
                        style: const TextStyle(fontSize: 20, color: Colors.black),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      );
    }).toList();


    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(''), // Título da página
        actions: const [ButtonNotification()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Olá aluno',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            const SizedBox(height: 20),
            Text(
              weekTitle,
              style: const TextStyle(fontSize: 24, color: Colors.black),
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: themeButtons,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: const SubMenuDefaultWidget(),
    );
  }
}
