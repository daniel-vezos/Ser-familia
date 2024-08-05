import 'package:app_leitura/widgets/card_ranking.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UsersList extends StatelessWidget {
  const UsersList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').orderBy('points', descending: true).snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
              child: Text('Erro ao carregar os usuários: ${snapshot.error}'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final users = snapshot.data!.docs;

        return ListView.builder(
          itemCount: users.length ,
          itemBuilder: (context, index) {
            final userData = users[index].data() as Map<String, dynamic>;
            final userName = userData['name'] ?? 'Nome desconhecido'; // Verifique se o campo do nome está correto
            final userPoints = userData['points'] ?? 0; // Verifique se o campo dos pontos está correto
            return CardRanking(
              nameUser: userName,
              points: userPoints,
              rank: index + 1, // Posição no ranking (começando do 1)
            );
          },
        );
      },
    );
  }
}
