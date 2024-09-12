import 'dart:async'; // Adicionado para usar o Timer
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
  bool _isLoading = false;
  final TextEditingController _matriculaController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _auth = AuthService();
  Timer? _timer; // Declarar o Timer

  @override
  void initState() {
    super.initState();
    _checkIfUserIsLoggedIn();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancelar o Timer, se estiver ativo
    _matriculaController.dispose(); // Liberar o controlador do TextField
    super.dispose();
  }

  Future<void> _checkIfUserIsLoggedIn() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          // Verificar se o widget ainda está montado
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Usuário não está autenticado.')),
          );
        }
      });
      return;
    }

    try {
      final userId = user.uid;
      final userDoc = await _firestore.collection('users').doc(userId).get();
      final privacyAccepted =
          userDoc.data()?['privacyAccepted'] as bool? ?? false;

      if (privacyAccepted) {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => InitialHome(
                nameUser: user.displayName ?? 'Usuário',
              ),
            ),
          );
        }
      } else {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => PrivacityPageController(
                nameUser: user.displayName ?? 'Usuário',
              ),
            ),
          );
        }
      }
    } catch (e) {
      print('Erro ao verificar o status da política de privacidade: $e');
    }
  }

  Future<void> _authenticate() async {
    final matricula = _matriculaController.text;

    if (matricula.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Por favor, preencha o campo com sua matrícula')),
          );
        }
      });
      return;
    }

    try {
      final doc =
          await _firestore.collection('matriculas').doc(matricula).get();

      if (doc.exists) {
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InitialHome(
                nameUser: matricula,
              ),
            ),
          );
        }
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Matrícula não encontrada')),
            );
          }
        });
      }
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erro: $e')),
          );
        }
      });
    }
  }

  Future<void> _showLoginSuccessDialog(String userName) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Usuário não autenticado.')),
          );
        }
      });
      return;
    }

    try {
      final userDoc = await _firestore.collection('users').doc(userId).get();
      final privacyAccepted =
          userDoc.data()?['privacyAccepted'] as bool? ?? false;

      if (privacyAccepted) {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => InitialHome(
                nameUser: userName,
              ),
            ),
          );
        }
      } else {
        if (mounted) {
          return showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Bem-vindo!'),
                content: const Text(
                    'Antes de começar, por favor, leia nossa política de privacidade.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      if (mounted) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PrivacityPageController(
                              nameUser: userName,
                            ),
                          ),
                        );
                      }
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
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
        if (_isLoading)
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
                  _isLoading = true;
                });
                User? user = await _auth.loginWithGoogle();
                if (mounted) {
                  setState(() {
                    _isLoading = false;
                  });
                }
                if (user != null) {
                  if (mounted) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InitialHome(
                          nameUser: user.displayName ?? 'Usuário',
                        ),
                      ),
                    );
                    _showLoginSuccessDialog(user.displayName ?? 'Usuário');
                  }
                } else {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Falha no login')),
                      );
                    }
                  });
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
        color: const Color.fromARGB(255, 6, 48, 81),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: colorText,
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
