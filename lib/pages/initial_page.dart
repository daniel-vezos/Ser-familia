import 'dart:ui';
import 'package:app_leitura/auth/auth_service.dart';
import 'package:app_leitura/controller/privacity_page_controller.dart';
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
  bool _isTextFieldFocused = false;
  bool _isLoading = false; // Estado para o carregamento
  final TextEditingController _matriculaController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _auth = AuthService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _checkIfUserIsLoggedIn();
    });
  }

  Future<void> _checkIfUserIsLoggedIn() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuário não está autenticado.')),
      );
      return;
    }

    // Verificar o status da política de privacidade do usuário
    try {
      final userId = user.uid;
      final userDoc = await _firestore.collection('users').doc(userId).get();
      final privacyAccepted = userDoc.data()?['privacyAccepted'] as bool? ?? false;

      if (privacyAccepted) {
        // Se a política de privacidade já foi aceita, redireciona para a tela inicial
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => InitialHome(
              nameUser: user.displayName ?? 'Usuário',
            ),
          ),
        );
      }
    } catch (e) {
      print('Erro ao verificar o status da política de privacidade: $e');
    }
  }

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

  Future<void> _showLoginSuccessDialog(String userName) async {
    // Verificar o status da política de privacidade do usuário
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        throw Exception('Usuário não autenticado.');
      }

      final userDoc = await _firestore.collection('users').doc(userId).get();
      final privacyAccepted = userDoc.data()?['privacyAccepted'] as bool? ?? false;

      if (privacyAccepted) {
        // Se a política de privacidade já foi aceita, não exiba o diálogo
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => InitialHome(
              nameUser: userName,
            ),
          ),
        );
      } else {
        // Se a política de privacidade não foi aceita, exiba o diálogo
        return showDialog<void>(
          context: context,
          barrierDismissible: false, // Impede o usuário de fechar o diálogo tocando fora
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Bem-vindo!'),
              content: const Text(
                  'Antes de começar, por favor, leia nossa política de privacidade.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    // Ação ao pressionar "OK": redirecionar para a política de privacidade
                    Navigator.of(context).pop(); // Fecha o diálogo
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PrivacityPageController(
                          nameUser: userName,
                        ), // Adicione a página da política de privacidade
                      ),
                    );
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print('Erro ao verificar o status da política de privacidade: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          setState(() {
            _isTextFieldFocused = false;
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
            if (_isTextFieldFocused)
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ),
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
        if (_isLoading) // Exibe o indicador de carregamento se _isLoading for verdadeiro
          const Center(
            child: CircularProgressIndicator(),
          ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 200.0),
            child: CustomButtonNavigation(
              onPressed: () async {
                setState(() {
                  _isLoading = true; // Inicia o carregamento
                });
                User? user = await _auth.loginWithGoogle();
                setState(() {
                  _isLoading = false; // Termina o carregamento
                });
                if (user != null) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InitialHome(
                        nameUser: user.displayName ?? 'Usuário',
                      ),
                    ),
                  );
                  // Mostra o AlertDialog após o login
                  _showLoginSuccessDialog(user.displayName ?? 'Usuário');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Falha no login')),
                  );
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
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: colorText, // Cor do texto
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                title,
                style: TextStyle(
                  color: colorText,
                  fontSize: 10,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
