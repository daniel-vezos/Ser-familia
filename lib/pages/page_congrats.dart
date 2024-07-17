import 'package:app_leitura/pages/level_completed.dart';
import 'package:app_leitura/pages/page_trophy.dart';
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
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(24),
                    elevation: 8,
                    shadowColor: Colors.black.withOpacity(0.3),
                  ),
                  child: const Icon(Icons.check, color: Colors.white, size: 30),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 300, // Largura do botão
                  height: 50, // Altura do botão
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LevelCompletedPage(nameUser: widget.nameUser)),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(
                          255, 1, 121, 219), // Cor de fundo do botão
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      elevation: 8,
                      shadowColor: Colors.black.withOpacity(0.3),
                    ),
                    child: const Text(
                      'Parabéns!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Cor do texto
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
