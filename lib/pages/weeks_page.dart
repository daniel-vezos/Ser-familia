import 'package:app_leitura/pages/page_theme.dart';
import 'package:flutter/material.dart';

import '../widgets/button_default.dart'; // Certifique-se de que o caminho esteja correto
import '../widgets/sub_menu_home_widget.dart';

class WeeksPage extends StatefulWidget {
  const WeeksPage({super.key});

  @override
  State<WeeksPage> createState() => _WeeksPageState();
}

class _WeeksPageState extends State<WeeksPage> {
  final String aluno = "Aluno";
  final List<String> semanas = [
    'Semana 1',
    'Semana 2',
    'Semana 3',
    'Semana 4',
    'Semana 5',
    'Semana 6',
    'Semana 7',
    'Semana 8',
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> buttons = [];

    for (String titulo in semanas) {
      buttons.add(
        Column(
          children: [
            CustomButtonDefault(
              title: titulo,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PageTheme()),
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Olá, $aluno'),
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {
                // Ação ao clicar no ícone de notificação
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'ATIVIDADES SEMANAIS',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Column(
              children: buttons,
            ),
          ],
        ),
      ),
      bottomNavigationBar: const MenuHomeWidget(),
    );
  }
}
