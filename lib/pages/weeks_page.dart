import 'package:app_leitura/widgets/button_notification.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/button_default.dart';
import '../widgets/sub_menu_widget.dart';
import 'page_theme.dart';

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
        actions: const [ButtonNotification()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Olá, Aluno',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'ATIVIDADES SEMANAIS',
              style: GoogleFonts.syne(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Column(
              children: buttons,
            ),
          ],
        ),
      ),
      bottomNavigationBar: const SubMenuDefaultWidget(),
    );
  }
}
