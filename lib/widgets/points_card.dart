import 'package:app_leitura/pages/level_completed.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PointsCard extends StatelessWidget {
  final String userId;

  const PointsCard({super.key, required this.userId});

  Future<int> _fetchPoints() async {
    try {
      final userDoc = FirebaseFirestore.instance.collection('user').doc(userId);
      final snapshot = await userDoc.get();
      return snapshot.data()?['points'] ?? 0;
    } catch (e) {
      print('Erro ao buscar pontos: ${e.toString()}');
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: _fetchPoints(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Erro: ${snapshot.error}');
        }

        final points = snapshot.data ?? 0;

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
                MaterialPageRoute(builder: (context) => const LevelCompletedPage(nameUser: 'teste')),
              );
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$points',
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
      },
    );
  }
}
