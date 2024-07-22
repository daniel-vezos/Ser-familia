import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  final String inconImagePath;
  final String tileTile;
  final String tilesubTile;
  final VoidCallback? onTap;

  const MyListTile({
    super.key,
    required this.inconImagePath,
    required this.tileTile,
    required this.tilesubTile,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(inconImagePath),
      title: Center(child: Text(tileTile)), // Centraliza o texto do título
      subtitle:
          Center(child: Text(tilesubTile)), // Centraliza o texto do subtítulo
      onTap: onTap,
    );
  }
}
