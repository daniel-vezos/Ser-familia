import 'dart:ui';
import 'package:app_leitura/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'initial_home.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  final bool _isTextFieldFocused = false;
  final TextEditingController _matriculaController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _auth = AuthService();

  Future<void> _authenticate() async {
    final matricula = _matriculaController.text;

    if (matricula.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Por favor, preencha o campo com sua matrícula')),
      );
      return;
    }

    try {
      final doc =
          await _firestore.collection('matriculas').doc(matricula).get();

      if (doc.exists) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InitialHome(
              nameUser: matricula,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Matrícula não encontrada')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          setState(() {
            _isTextFieldFocused == true ? false : null;
          });
        },
        child: Stack(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/backgrounds/logincerto.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            _isTextFieldFocused == true
                ? Positioned.fill(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                      child: Container(
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  )
                : Container(),
            _contentInitialPage(context),
          ],
        ),
      ),
    );
  }

  Column _contentInitialPage(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        const SizedBox(
          height: 150,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              SizedBox(height: 15),
            ],
          ),
        ),
        const Spacer(),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 150.0),
            child: CustomButtonNavigation(
              onPressed: () async {
                User? user = await _auth.loginWithGoogle();
                if (user != null) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InitialHome(
                        nameUser: user.displayName ?? 'Usuário',
                      ),
                    ),
                  );
                } else {
                  print('Falha no login');
                }
              },
              title: 'Conectar com Google',
              width: 250,
              height: 45,
              colorText: Colors.white,
              icon: Image.asset(
                'assets/icons/googleIcon1.png',
                width: 20,
                height: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomButtonNavigation extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final double width;
  final double height;
  final Color colorText;
  final Widget icon;

  const CustomButtonNavigation({
    super.key,
    required this.onPressed,
    required this.title,
    required this.width,
    required this.height,
    required this.colorText,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: const Color.fromARGB(
            255, 6, 48, 81), // Define a cor azul para o botão
        borderRadius: BorderRadius.circular(8),
        // Remova a sombra
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: colorText, // Cor do texto
          padding: EdgeInsets.zero,
          backgroundColor:
              const Color.fromARGB(255, 0, 0, 0), // Define a cor azul
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: colorText,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
