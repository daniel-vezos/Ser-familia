import 'package:flutter/material.dart';

class LevelCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final VoidCallback onPressed;

  const LevelCard({
    required this.imagePath,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        elevation: 5,
        child: Column(
          children: [
            Image.asset(imagePath),
            Text(title),
          ],
        ),
      ),
    );
  }
}
