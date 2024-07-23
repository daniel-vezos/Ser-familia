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
            borderRadius: BorderRadius.circular(10),
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
      appBar: AppBar(
        actions: [
            PointsCard(userId: user.uid),
            const SizedBox(width: 16),
            ButtonNotification(nameUser: widget.nameUser),
          ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Olá, ${widget.nameUser}',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
              ),
              const SizedBox(height: 20),
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
      bottomNavigationBar: SubMenuWidget(nameUser: widget.nameUser),
    );
  }
}
