import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'initial_home.dart';
import 'package:app_leitura/widgets/custom_button_navigation.dart';
import 'package:flutter/services.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  bool _isTextFieldFocused = false;
  final TextEditingController _matriculaController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _authenticate() async {
    final matricula = _matriculaController.text;

    if (matricula.isEmpty) {
      // Exibir mensagem se o campo de matrícula estiver vazio
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha o campo com sua matrícula')),
      );
      return;
    }

    try {
      final doc = await _firestore.collection('matriculas').doc(matricula).get();

      if (doc.exists) {
        // Matricula encontrada
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => InitialHome(name: doc['name'])),
        );
      } else {
        // Matricula não encontrada
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
                  image: AssetImage("assets/backgrounds/backgroundInitialPage.png"),
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
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 12, right: 12),
              child: Row(
                children: [
                  Text(
                    "Sua família conectada!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        const Center(
          child: Padding(
            padding: EdgeInsets.only(left: 12, right: 12),
            child: Text(
              "Aqui tem disponível conteúdos para você e sua família",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
        const SizedBox(height: 35),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Focus(
              onFocusChange: (hasFocus) {
                setState(() {
                  _isTextFieldFocused = hasFocus;
                });
              },
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  setState(() {
                    _isTextFieldFocused = true;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: TextField(
                    controller: _matriculaController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Matrícula",
                      hintStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            CustomButtonNavigation(
              onPressed: _authenticate,
              title: 'Acessar',
              width: 175,
              height: 40,
            ),
          ],
        ),
        const SizedBox(height: 120),
      ],
    );
  }
}
