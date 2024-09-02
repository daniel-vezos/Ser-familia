import 'package:flutter/material.dart';

class CustomButtonNavigation extends StatefulWidget {
  final String title;
  final double width;
  final double height;
  final Color colorBackground;
  final Color colorText;
  final double radius;
  final Function() onPressed;
  final Widget? icon; // Adiciona a propriedade para o ícone

  const CustomButtonNavigation({
    super.key,
    required this.title,
    required this.width,
    required this.height,
    required this.onPressed,
    this.colorBackground = Colors.orange,
    this.colorText = Colors.black,
    this.radius = 10,
    this.icon, // Inicializa a propriedade do ícone
  });

  @override
  State<CustomButtonNavigation> createState() => CustomButtonNavigationState();
}

class CustomButtonNavigationState extends State<CustomButtonNavigation> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.colorBackground,
      borderRadius: BorderRadius.circular(widget.radius),
      child: InkWell(
        onTap: widget.onPressed,
        child: Container(
          alignment: Alignment.center,
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.radius),
            boxShadow: [
              BoxShadow(
                color: widget.colorBackground,
                blurStyle: BlurStyle.normal,
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                widget.icon!,
                const SizedBox(width: 8), // Espaço entre o ícone e o texto
              ],
              Text(
                widget.title,
                style: TextStyle(
                  color: widget.colorText,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
