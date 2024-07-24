import 'package:app_leitura/widgets/card_ranking.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UsersList extends StatelessWidget {
  const UsersList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Erro ao carregar os usuários: ${snapshot.error}'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        
        final users = snapshot.data!.docs;

        return ListView.builder(
          itemCount: users.length - 1,
          itemBuilder: (context, index) {
            final userData = users[index].data() as Map<String, dynamic>;
            final userName = userData['name'] ?? 'Nome desconhecido'; // Coloque o campo correto do nome do usuário
            final userPoints = userData['points'] ?? 0; // Coloque o campo correto dos pontos do usuário
            return CardRanking(
              nameUser: userName.split(' ')[0], // Passar apenas o primeiro nome
              points: userPoints,
            );
          },
        );
      },
    );
  }
}
