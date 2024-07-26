import 'package:app_leitura/models/userList.dart';
import 'package:app_leitura/widgets/button_notification.dart';
import 'package:app_leitura/widgets/card_ranking.dart';
import 'package:app_leitura/widgets/points_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/sub_menu_widget.dart';

class RankingPage extends StatelessWidget {
  final String nameUser;

  const RankingPage({
    super.key,
    required this.nameUser,
  });

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Center(child: Text('Usuário não autenticado.'));
    }

    List<String> nameParts = nameUser.split(' ');
    String firstName = nameParts.first;
    String lastName = nameParts.last;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        // title: Text(
        //   'Olá $nameUser',
        //   style: const TextStyle(
        //     fontFamily: 'Roboto',
        //   ),
        // ),
        actions: [
          PointsCard(userId: user.uid),
          const SizedBox(width: 16),
          ButtonNotification(nameUser: nameUser),
        ],
      ),
      body: Container(
        color: Colors.grey[300], // Define a cor de fundo
        padding: const EdgeInsets.all(20.0),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Ranking',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(child: UsersList()),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: SubMenuWidget(nameUser: nameUser),
    );
  }
}
