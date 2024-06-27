import 'package:app_leitura/widgets/button_notification.dart';
import 'package:flutter/material.dart';
import '../widgets/sub_menu_widget.dart';
import 'page_tasks.dart';

class PageTheme extends StatelessWidget {
  const PageTheme({super.key});

  @override
  Widget build(BuildContext context) {
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
            const Text(
              'Semana 1',
              style: TextStyle(fontSize: 24, color: Colors.black),
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 60, // Altura aumentada dos botões
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PageTasks()),
                      );
                    },
                    icon: Image.asset(
                      'assets/backgrounds/botao1.png',
                      height: 35, // Altura do ícone
                      width: 100, // Largura do ícone
                    ),
                    label: const Text(
                      'História de Família',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 60, // Altura aumentada dos botões
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PageTasks()),
                      );
                    },
                    icon: Image.asset(
                      'assets/backgrounds/botao1.png',
                      height: 35, // Altura do ícone
                      width: 100, // Largura do ícone
                    ),
                    label: const Text(
                      'Esforço e Dedicação',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 60, // Altura aumentada dos botões
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PageTasks()),
                      );
                    },
                    icon: Image.asset(
                      'assets/backgrounds/botao1.png',
                      height: 35, // Altura do ícone
                      width: 100, // Largura do ícone
                    ),
                    label: const Text(
                      'Qual é o meu sonho?',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: const SubMenuDefaultWidget(),
    );
  }
}
