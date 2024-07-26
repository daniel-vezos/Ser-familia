import 'package:flutter/material.dart';

class CardRanking extends StatefulWidget {
  final String nameUser;
  final int points; // Adicionamos um novo campo para os pontos
  const CardRanking({
    super.key,
    required this.nameUser,
    required this.points, // Recebe os pontos como parâmetro
  });

  @override
  State<CardRanking> createState() => _CardRankingState();
}

class _CardRankingState extends State<CardRanking> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xff012363),
          ),
          height: 60,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '#1',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  widget.nameUser,
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  '${widget.points}', // Mostra os pontos dinamicamente
                  style: const TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
