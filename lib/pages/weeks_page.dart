import 'package:app_leitura/widgets/button_notification.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import '../widgets/button_default.dart';
import '../widgets/sub_menu_widget.dart';
import 'page_theme.dart';
import '../data/weeks_data.dart'; // Import the JSON string

class WeeksPage extends StatefulWidget {
  const WeeksPage({super.key});

  @override
  State<WeeksPage> createState() => _WeeksPageState();
}

class _WeeksPageState extends State<WeeksPage> {
  final String aluno = "Aluno";
  final List<String> semanas = [];
  late Map<String, List<Map<String, dynamic>>> themesByWeek;

  @override
  void initState() {
    super.initState();
    _loadWeeks();
  }

  void _loadWeeks() {
    Map<String, dynamic> jsonData = json.decode(weeks);
    themesByWeek = jsonData.map((key, value) {
      return MapEntry(key, List<Map<String, dynamic>>.from(value));
    });
    setState(() {
      semanas.addAll(jsonData.keys);
    });
  }

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
                  MaterialPageRoute(
                    builder: (context) => PageTheme(
                      weekTitle: titulo,
                      themes: themesByWeek[titulo] ?? [],
                    ),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(10),
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
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          Column(
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
        ],
      ),
      bottomNavigationBar: const SubMenuDefaultWidget(),
    );
  }
}
