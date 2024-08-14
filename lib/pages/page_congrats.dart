import 'package:app_leitura/pages/page_theme.dart'; // Certifique-se de que esta importação está correta
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:lottie/lottie.dart'; // Certifique-se de ter esta dependência no pubspec.yaml
import 'dart:async';

class CongratsPage extends StatefulWidget {
  final String nivel;
  final String nameUser;
  final String weekTitle;
  final List<Map<String, dynamic>> themes;
  final String title;

  const CongratsPage({
    super.key,
    required this.nivel,
    required this.nameUser,
    required this.weekTitle,
    required this.themes,
    required this.title,
  });

  @override
  _CongratsPageState createState() => _CongratsPageState();
}

class _CongratsPageState extends State<CongratsPage> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 10));
    _confettiController.play();
    Timer(const Duration(seconds: 3), () {
      if (mounted) { // Verifica se o widget ainda está montado antes de navegar
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => PageTheme(
              nameUser: widget.nameUser,
              weekTitle: widget.title,
              themes: widget.themes,
              nivel: widget.nivel,
            ),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.grey[300], // Define a cor de fundo para o Scaffold
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Container(
              color: Colors.grey[300], // Define a cor de fundo para o Container
              child: Lottie.asset(
                'assets/animations/trofeu.json',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
