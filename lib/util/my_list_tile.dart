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
      title: Center(
        child: Text(
          tileTile,
          style: const TextStyle(
            fontSize: 20, // Aumenta o tamanho da fonte do título
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      subtitle: Center(
        child: Text(
          tilesubTile,
          style: const TextStyle(
            fontSize: 20, // Aumenta o tamanho da fonte do subtítulo
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
