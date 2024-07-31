import 'package:app_leitura/widgets/button_notification.dart';
import 'package:app_leitura/widgets/points_card.dart';
import 'package:flutter/material.dart';
import '../widgets/sub_menu_widget.dart';

class PrivacyPolicyPage extends StatelessWidget {
  final String nameUser;

  const PrivacyPolicyPage({
    super.key,
    required this.nameUser,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        actions: [
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
      ),
      body: Container(
        color: Colors.grey[300], // Define a cor de fundo
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment
                .center, // Alinha o conteúdo no centro verticalmente
            children: [
              Text('Página de Política de Privacidade'),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SubMenuWidget(nameUser: nameUser),
    );
  }
}
