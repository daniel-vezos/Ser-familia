
import 'package:flutter/material.dart';

import '../widgets/sub_menu_widget.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({super.key});

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {
                // Ação ao clicar no ícone de notificação
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Column(
          children: [
            Text('Pagina de Politica de Privacidade')
          ],
        ),
      ),
      bottomNavigationBar: const SubMenuDefaultWidget(),
    );
  }
}