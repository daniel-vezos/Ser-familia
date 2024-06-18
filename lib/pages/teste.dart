import 'package:app_leitura/widgets/custom_button_navigation.dart';
import 'package:flutter/material.dart';

class PaginaTeste extends StatefulWidget {
  const PaginaTeste({super.key});

  @override
  State<PaginaTeste> createState() => _PaginaTesteState();
}

class _PaginaTesteState extends State<PaginaTeste> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: <Widget>[
        Text('PaginaTeste'),
      ],
    );
  }
}