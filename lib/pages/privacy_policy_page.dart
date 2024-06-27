
import 'package:app_leitura/widgets/button_notification.dart';
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
        actions: const [ButtonNotification()],
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