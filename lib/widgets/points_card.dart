import 'package:app_leitura/pages/level_completed.dart';
import 'package:flutter/material.dart';

class PointsCard extends StatelessWidget {
  final int amount;

  const PointsCard({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(100)),
        color: Color(0xff3765B0),
      ),
      child: GestureDetector(
        onTap: () {
            Navigator.push(
              context,
            MaterialPageRoute(builder: (context) => const LevelCompletedPage(nameUser: 'teste',))
          );
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$amount',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 5),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(100))
              ),
              child: Image.asset(
                'assets/icons/coin.png',
                width: 22,
                height: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
