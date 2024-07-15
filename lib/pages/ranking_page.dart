import 'package:app_leitura/widgets/button_notification.dart';
import 'package:app_leitura/widgets/card_ranking.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../widgets/sub_menu_widget.dart';

class RankingPage extends StatelessWidget {
  final String nameUser;
  
  const RankingPage({
    super.key,
    required this.nameUser,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Olá, primeiro nome'), // Título da página
        actions: [ButtonNotification(nameUser: nameUser)],
      ),
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Ranking',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
            SizedBox(height: 20),
            Column(
              
              children: [
                CardRanking(),
                CardRanking(),
                CardRanking(),
                CardRanking(),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: SubMenuDefaultWidget(nameUser: nameUser),
    );
  }
}
