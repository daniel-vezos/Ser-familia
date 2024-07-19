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
    required this.nameUser
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
    return Scaffold(
      appBar: AppBar(
        actions: [
          const PointsCard(amount: 0),
          const SizedBox(width: 16),
          ButtonNotification(nameUser: nameUser),
        ],
      ),
      body: Padding(
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
                      MaterialPageRoute(builder: (context) => PrivacyPolicyPage(nameUser: nameUser))
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
                      MaterialPageRoute(builder: (context) => TermsOfUsePage(nameUser: nameUser))
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
                const SizedBox(height: 32),
                GestureDetector(
                  onTap: () => _signOut(context),
                  child: const Row(
                    children: [
                      Text(
                        'Sair da conta',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Email de contato para suporte:',
                  style: TextStyle(fontSize: 15),
                ),
                Text('contato@contato.com')
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: SubMenuWidget(nameUser: nameUser),
    );
  }
}