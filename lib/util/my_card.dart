import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final String imagePath;
  final String? title;
  final VoidCallback? onPressed;
  final bool isUnlocked;
  final Color color;

  const MyCard({
    super.key,
    required this.imagePath,
    this.title,
    this.onPressed,
    this.isUnlocked = true,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Opacity(
        opacity: isUnlocked ? 1.0 : 0.5,
        child: GestureDetector(
          onTap: isUnlocked ? onPressed : null,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.7,
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Usando ClipRRect para bordas arredondadas na imagem
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    imagePath,
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.19,
                    fit: BoxFit.contain,
                  ),
                ),
                if (title != null) ...[
                  const SizedBox(height: 8),
                  Flexible(
                    child: Text(
                      title!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
