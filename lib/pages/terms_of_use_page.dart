
import 'package:flutter/material.dart';

import '../widgets/sub_menu_widget.dart';

class TermsOfUsePage extends StatefulWidget {
  const TermsOfUsePage({super.key});

  @override
  State<TermsOfUsePage> createState() => _TermsOfUsePageState();
}

class _TermsOfUsePageState extends State<TermsOfUsePage> {
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
            Text('Pagina de Termos de Uso')
          ],
        ),
      ),
      bottomNavigationBar: const SubMenuDefaultWidget(),
    );
  }
}