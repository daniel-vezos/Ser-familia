
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
      body: const Center(
        child: Column(
          children: [
            Text('Pagina de Politica de Privacidade')
          ],
        ),
      ),
      bottomNavigationBar: SubMenuWidget(nameUser: nameUser),
    );
  }
}