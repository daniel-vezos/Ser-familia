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
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Lottie.asset(
              'assets/animations/trofeu.json',
              width: double
                  .infinity, // Use double.infinity para ocupar todo o espaço disponível
              height: double
                  .infinity, // Use double.infinity para ocupar todo o espaço disponível
              fit: BoxFit
                  .fitWidth, // Ajuste a opção de ajuste (fit) conforme necessário
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
