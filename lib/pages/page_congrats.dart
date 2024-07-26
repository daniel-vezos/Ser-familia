import 'package:app_leitura/pages/level_completed.dart';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:lottie/lottie.dart'; // Certifique-se de ter esta dependência no pubspec.yaml

class CongratsPage extends StatefulWidget {
  final String nameUser;
  const CongratsPage({
    super.key,
    required this.nameUser,
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
