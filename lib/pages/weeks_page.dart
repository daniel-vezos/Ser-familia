import 'package:app_leitura/widgets/points_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import '../widgets/button_notification.dart';
import '../widgets/button_default.dart';
import '../widgets/sub_menu_widget.dart';
import 'page_theme.dart';
import '../data/weeks_data.dart'; // Import the JSON string

class WeeksPage extends StatefulWidget {
  final String nivel;
  final String nameUser;

  const WeeksPage({
    super.key,
    required this.nivel,
    required this.nameUser,
    required String userName,
    required titles,
  });

  @override
  State<WeeksPage> createState() => _WeeksPageState();
}

class _WeeksPageState extends State<WeeksPage> {
  late Map<String, List<Map<String, dynamic>>> themesByWeek = {};
  List<String> semanas = [];

  @override
  void initState() {
    super.initState();
    _loadWeeks();
  }

  void _loadWeeks() {
    try {
      Map<String, dynamic> jsonData = json.decode(weeks);
      Map<String, dynamic> selectedLevel = jsonData[widget.nivel];

      themesByWeek = selectedLevel.map((key, value) {
        return MapEntry(key, List<Map<String, dynamic>>.from(value));
      });

      setState(() {
        semanas = selectedLevel.keys.toList();
      });
    } catch (e) {
      print('Erro ao carregar semanas: $e');
      // Handle JSON parsing error
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle buttonStyle = GoogleFonts.syne(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    );

    TextStyle headerStyle = GoogleFonts.syne(
      fontSize: 24, // Aumenta o tamanho da fonte para 24
      fontWeight: FontWeight.w800,

      color: Colors.black,
    );

    List<Widget> buttons = semanas.map((titulo) {
      return Column(
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
                    nameUser: widget.nameUser,
                  ),
                ),
              );
            },
            borderRadius: BorderRadius.circular(15),
            textStyle: buttonStyle, // Aplica o estilo do texto ao botão
          ),
          const SizedBox(height: 20),
        ],
      );
    }).toList();

    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Center(child: Text('Usuário não autenticado.'));
    }

    return Scaffold(
      backgroundColor: Colors.grey[300], // Define a cor de fundo
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        actions: [
            PointsCard(userId: user.uid),
            const SizedBox(width: 16),
            ButtonNotification(nameUser: widget.nameUser),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.notifications),
              ),
            ),
          ],
      ),
      body: Container(
        color:
            Colors.grey[300], // Garante que toda a área de rolagem esteja cinza
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Olá ${widget.nameUser}",
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.nameUser,
                      style: const TextStyle(fontSize: 28),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'ATIVIDADES SEMANAIS',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 20),
                Column(
                  children: buttons,
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: SubMenuWidget(nameUser: widget.nameUser),
    );
  }
}
