import 'package:app_leitura/pages/initial_page.dart';
import 'package:app_leitura/pages/privacy_page.dart';
import 'package:app_leitura/pages/privacy_policy_page.dart';
import 'package:app_leitura/pages/terms_of_use_page.dart';
import 'package:app_leitura/widgets/button_notification.dart';
import 'package:app_leitura/widgets/points_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../widgets/sub_menu_widget.dart';

class ProfilePage extends StatelessWidget {
  final String nameUser;

  const ProfilePage({
    super.key,
    required this.nameUser,
  });

  Future<void> _deleteUser(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      // Confirme a exclusão com o usuário
      final confirm = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Confirmar Exclusão'),
          content: const Text('Tem certeza de que deseja excluir sua conta? Esta ação é irreversível.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Excluir'),
            ),
          ],
        ),
      );

      if (confirm != true) return;

      // Apaga todos os dados do Firestore associados ao usuário
      await _deleteUserData(user.uid);

      // Remove o usuário
      await user.delete();

      // Logout do Firebase Auth
      await FirebaseAuth.instance.signOut();

      // Redireciona para a tela inicial após a exclusão
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const InitialPage()),
        (route) => false,
      );
    } catch (e, stackTrace) {
      print('Erro ao excluir conta: ${e.toString()}');
      print('StackTrace: $stackTrace');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao excluir a conta.')),
      );
    }
  }


  Future<void> _deleteUserData(String uid) async {
    try {
      final firestore = FirebaseFirestore.instance;
      await firestore.collection('users').doc(uid).delete();
      print('Dados do usuário excluídos com sucesso.');
    } catch (e) {
      print('Erro ao excluir dados do Firestore: ${e.toString()}');
      rethrow;
    }
  }

  Future<void> _signOut(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      await googleSignIn.signOut();
      await FirebaseAuth.instance.signOut();
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
          icon: Icon(Icons.arrow_back, color: Colors.grey[600]),
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
        backgroundColor: Colors.grey[300],
        elevation: 0,
      ),
      body: Container(
        color: Colors.grey[300],
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
                        builder: (context) => PrivacyPolicyPage(),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.lock, color: Colors.grey[600]),
                      const SizedBox(width: 8),
                      const Text(
                        'Política de Privacidade',
                        style: TextStyle(fontSize: 18),
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
                        builder: (context) => TermsOfUsePage(nameUser: nameUser),
                      ),
                    );
                  },
                  child: const Row(
                    children: [
                      Text(
                        'Termos de Uso',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                GestureDetector(
                  onTap: () => _deleteUser(context),
                  child: const Row(
                    children: [
                      Text(
                        'Excluir a conta',
                        style: TextStyle(fontSize: 18),
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
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  textStyle: const TextStyle(fontSize: 18),
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
