import "package:flutter/material.dart";

class CustomButtonNavigation extends StatefulWidget {  
  final String title;
  final double width;
  final double height;
  const CustomButtonNavigation({
    super.key, 
    required this.title, 
    required this.width, 
    required this.height,
  });

  @override
  State<CustomButtonNavigation> createState() => CustomButtonNavigationState();
}

class CustomButtonNavigationState extends State<CustomButtonNavigation> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Text(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold
        ),
        widget.title
      ),
    );
  }
}