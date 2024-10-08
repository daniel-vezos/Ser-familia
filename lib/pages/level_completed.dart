import 'package:app_leitura/widgets/button_notification.dart';
import 'package:app_leitura/widgets/points_card.dart';
import 'package:app_leitura/widgets/sub_menu_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LevelCompletedPage extends StatefulWidget {
  final String nameUser;
  const LevelCompletedPage({
    super.key,
    this.nameUser = '',
  });

  @override
  _LevelCompletedPageState createState() => _LevelCompletedPageState();
}

class _LevelCompletedPageState extends State<LevelCompletedPage> {
  int _maxUnlockedLevel = 0;

  @override
  void initState() {
    super.initState();
    _fetchUserPoints();
  }

  void _fetchUserPoints() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }

    try {
      final userDoc = FirebaseFirestore.instance.collection('users').doc(user.uid);
      final docSnapshot = await userDoc.get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data()!;
        int points = data['points'] ?? 0;
        
        // Calcular o nível desbloqueado com base nos pontos
        setState(() {
          _maxUnlockedLevel = (points ~/ 120);
          // Limitar o máximo nível a 9
          _maxUnlockedLevel = _maxUnlockedLevel > 9 ? 9 : _maxUnlockedLevel;
        });
      }
    } catch (e) {
      print('Erro ao buscar pontos do usuário: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> imagePaths = [
      'assets/backgrounds/teste.png',
      'assets/backgrounds/teste2.png',
      'assets/backgrounds/teste3.png',
      'assets/backgrounds/teste4.png',
      'assets/backgrounds/teste5.png',
      'assets/backgrounds/teste6.png',
      'assets/backgrounds/teste7.png',
      'assets/backgrounds/teste8.png',
      'assets/backgrounds/teste9.png',
    ];

    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Center(child: Text('Usuário não autenticado.'));
    }

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        automaticallyImplyLeading: false,
        actions: [
          PointsCard(userId: user.uid),
          const SizedBox(width: 16),
          ButtonNotification(nameUser: widget.nameUser),
          const SizedBox(width: 16),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
          ),
          itemCount: imagePaths.length,
          itemBuilder: (BuildContext context, int index) {
            bool isUnlocked = index < _maxUnlockedLevel;

            return GestureDetector(
              onTap: isUnlocked
                  ? () {
                      // Ação ao clicar no card desbloqueado
                    }
                  : null,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        imagePaths[index],
                        fit: BoxFit.cover,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: double.infinity,
                          color: const Color.fromARGB(137, 222, 209, 209)
                              .withOpacity(0.6),
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Nível ${index + 1}',
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      if (isUnlocked)
                        Container(
                          color: Colors.black.withOpacity(0.2),
                          child: Center(
                            child: Image.asset(
                              'assets/backgrounds/trofeu.png', // Caminho para a imagem da medalha
                              width: 90,
                              height: 90,
                            ),
                          ),
                        ),
                      if (!isUnlocked)
                        Container(
                          color: Colors.black.withOpacity(0.5),
                          child: const Center(
                            child: Icon(
                              Icons.lock,
                              color: Colors.white,
                              size: 50,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: SubMenuWidget(nameUser: widget.nameUser),
    );
  }
}
