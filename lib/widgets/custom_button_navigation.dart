import "package:flutter/material.dart";

class CustomButtonNavigation extends StatefulWidget {  
  final String title;
  final double width;
  final double height;
  final Color color;
  final Function() onPressed;
  const CustomButtonNavigation({
    super.key,
    required this.title,
    required this.width,
    required this.height,
    required this.onPressed,
    this.color = const Color(0xffF0AE42),
  });

  @override
  State<CustomButtonNavigation> createState() => CustomButtonNavigationState();
}

class CustomButtonNavigationState extends State<CustomButtonNavigation> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.color,
      borderRadius: BorderRadius.circular(100),
      child: InkWell(
        onTap: widget.onPressed,
        child: Container(
          alignment: Alignment.center,
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(
                color: widget.color,
                blurStyle: BlurStyle.normal,
                blurRadius: 10, 
                offset: const Offset(0, 3),
              )
            ]
          ),
          child: Text(
            widget.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold
            )
          )
        ),
      ),
    );
  }
}