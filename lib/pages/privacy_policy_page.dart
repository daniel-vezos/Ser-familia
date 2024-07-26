import 'package:app_leitura/widgets/button_notification.dart';
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
      appBar: AppBar(
        actions: [ButtonNotification(nameUser: nameUser)],
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
