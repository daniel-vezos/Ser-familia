import 'package:flutter/material.dart';

import '../widgets/button_default.dart';
import '../widgets/sub_menu_home_widget.dart';

class WeeksPage extends StatefulWidget {
  const WeeksPage({super.key});

  @override
  State<WeeksPage> createState() => _WeeksPageState();
}

class _WeeksPageState extends State<WeeksPage> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Text('Weeks')
        ),
        bottomNavigationBar: MenuHomeWidget()
      ),
    );
  }
}