import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final String imagePath;
  final String? title; // Adiciona um parâmetro opcional para o título
  final VoidCallback? onPressed; // Atualiza para aceitar uma função opcional
  final bool isUnlocked; // Controle de desbloqueio

  const MyCard({
    super.key,
    required this.imagePath,
    this.title, // Permite título nulo
    this.onPressed, // Permite função opcional
    this.isUnlocked = true, 
    required Color color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Opacity(
        opacity: isUnlocked ? 1.0 : 0.5, // Ajusta a opacidade com base no desbloqueio
        child: GestureDetector(
          onTap: isUnlocked ? onPressed : null, // Ativa o toque somente se desbloqueado
          child: Container(
            width: 250,
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              // color: Colors.transparent, // Define a cor de fundo para o card
              // borderRadius: BorderRadius.circular(20),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.black.withOpacity(0.1),
              //     spreadRadius: 2,
              //     blurRadius: 5,
              //     offset: const Offset(0, 3), // Sombra do card
              //   ),
              // ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  imagePath,
                  width: 290,
                  height: 130,
                  fit: BoxFit.contain,
                ),
                if (title != null) ...[
                  const SizedBox(height: 10), // Espaço entre a imagem e o título
                  Text(
                    title!,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
