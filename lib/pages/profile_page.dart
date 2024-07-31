import 'package:app_leitura/pages/initial_page.dart';
import 'package:app_leitura/pages/privacy_policy_page.dart';
import 'package:app_leitura/pages/terms_of_use_page.dart';
import 'package:app_leitura/widgets/button_notification.dart';
import 'package:app_leitura/widgets/points_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../widgets/sub_menu_widget.dart';

class ProfilePage extends StatelessWidget {
  final String nameUser;

  const ProfilePage({
    super.key,
    required this.nameUser,
  });

  Future<void> _signOut(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      await googleSignIn.signOut();
      await FirebaseAuth.instance.signOut();
      // Redireciona para a tela inicial após o logout
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const InitialPage()),
        (route) => false,
      );
    } catch (e) {
      print('Erro ao deslogar: ${e.toString()}');
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: Colors.grey[600]), // Um cinza mais escuro
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          PointsCard(userId: user.uid),
          const SizedBox(width: 16),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[400],
              shape: BoxShape.circle,
            ),
            child: ButtonNotification(nameUser: nameUser),
          ),
        ],
        backgroundColor: Colors.grey[300], // Cor de fundo da AppBar
        elevation: 0, // Remove a sombra da AppBar
      ),
      body: Container(
        color: Colors.grey[300], // Define a cor de fundo
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PrivacyPolicyPage(nameUser: nameUser)),
                    );
                  },
                  child: const Row(
                    children: [
                      Text(
                        'Política de Privacidade',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              TermsOfUsePage(nameUser: nameUser)),
                    );
                  },
                  child: const Row(
                    children: [
                      Text(
                        'Termos de Uso',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Center(
              child: ElevatedButton(
                onPressed: () => _signOut(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff012363),
                  padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 32), // Ajusta o padding do botão
                  textStyle: const TextStyle(
                      fontSize: 18), // Ajusta o tamanho do texto
                ),
                child: const Text(
                  'Sair',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SubMenuWidget(nameUser: nameUser),
    );
  }
}
