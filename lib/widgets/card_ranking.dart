import 'package:flutter/material.dart';

class CardRanking extends StatefulWidget {
  const CardRanking({super.key});

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
            color: const Color(0xff4068B0),
          ),
          height: 50,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '#1',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  'Jhoniboy',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  '900',
                  style: TextStyle(
                      color: Colors.orange, fontWeight: FontWeight.bold),
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
