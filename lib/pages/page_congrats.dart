import 'package:app_leitura/pages/level_completed.dart';
import 'package:app_leitura/pages/page_theme.dart';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:lottie/lottie.dart'; // Certifique-se de ter esta dependência no pubspec.yaml
import 'dart:async';

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
    Timer(const Duration(seconds: 3), () {
      if (mounted) { // Verifica se o widget ainda está montado antes de navegar
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LevelCompletedPage(nameUser: widget.nameUser)),
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
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Lottie.asset(
              'assets/animations/trofeu.json',
              width: double
                  .infinity,
              height: double
                  .infinity,
              fit: BoxFit
                  .fitWidth,
            ),
          ),
          // Center(
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: <Widget>[
          //       ElevatedButton(
          //         onPressed: () {},
          //         style: ElevatedButton.styleFrom(
          //           backgroundColor: Colors.green,
          //           shape: const CircleBorder(),
          //           padding: const EdgeInsets.all(24),
          //           elevation: 2,
          //           shadowColor: Colors.black.withOpacity(0.3),
          //         ),
          //         child: const Icon(Icons.check, color: Colors.white, size: 30),
          //       ),
          //       const SizedBox(height: 20),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
