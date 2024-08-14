import 'package:app_leitura/models/userList.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app_leitura/pages/initial_home.dart';
import 'package:app_leitura/widgets/button_notification.dart';
import 'package:app_leitura/widgets/points_card.dart';
import 'package:app_leitura/widgets/sub_menu_widget.dart';

class RankingPage extends StatelessWidget {
  final String nameUser;

  const RankingPage({
    super.key,
    required this.nameUser,
  });

  Future<int> getUserPosition(String userId) async {
    try {
      // Obter a pontuação do usuário atual
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (!userDoc.exists) {
        return -1; // Usuário não encontrado
      }

      final userPoints = userDoc.data()?['points'] as int? ?? 0;

      // Obter todos os usuários e ordenar por pontos
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .orderBy('points', descending: true)
          .get();

      final userDocs = querySnapshot.docs;

      int position = 1;
      for (var doc in userDocs) {
        final points = doc.data()['points'] as int? ?? 0;
        if (doc.id == userId) {
          return position;
        }
        position++;
      }

      return -1; // Usuário não encontrado na lista (não deveria acontecer se o usuário existir)
    } catch (e) {
      print('Erro ao obter a posição do usuário: $e');
      return -1; // Em caso de erro
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Center(child: Text('Usuário não autenticado.'));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: const Text(
          'Ranking',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InitialHome(
                  nameUser: nameUser,
                ),
              ),
            );
          },
        ),
        actions: [
          PointsCard(userId: user.uid),
          const SizedBox(width: 16),
          Container(
            padding: const EdgeInsets.all(8),
            child: ButtonNotification(nameUser: nameUser),
          ),
        ],
      ),
      body: Container(
        color: Colors.grey[300],
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: FutureBuilder<int>(
                future: getUserPosition(user.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Erro: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final position = snapshot.data!;
                    return Text(
                      position == -1
                          ? 'Minha Posição #N/A'
                          : 'Minha Posição #$position',
                      style: const TextStyle(
                        fontSize: 20,
                        fontFamily: 'Roboto',
                      ),
                    );
                  } else {
                    return const Text('Minha Posição #N/A');
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
            const Expanded(child: UsersList()), // Usa a UsersList para mostrar os 10 primeiros
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: SubMenuWidget(nameUser: nameUser),
    );
  }
}
