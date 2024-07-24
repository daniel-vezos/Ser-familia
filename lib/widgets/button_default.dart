import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButtonDefault extends StatefulWidget {
  final Function() onPressed;
  final String title;
  final String? assetsPath; // Tornando opcional
  const CustomButtonDefault({
    super.key,
    required this.title,
    this.assetsPath, // Parâmetro opcional
    required this.onPressed,
    required BorderRadius borderRadius,
    required TextStyle textStyle,
  });

  @override
  State<CustomButtonDefault> createState() => _CustomButtonDefaultState();
}

class _CustomButtonDefaultState extends State<CustomButtonDefault> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 60),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            backgroundColor: Colors.grey[200], // Cor de fundo do botão
          ),
          onPressed: widget.onPressed,
          child: widget.assetsPath != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Image.asset(widget.assetsPath!,
                          width: 70, height: 40),
                    ),
                    Text(
                      widget.title,
                      style: GoogleFonts.syne(
                        fontSize: 20.0,
                        color: Colors.black, // Cor do texto
                      ),
                    ),
                  ],
                )
              : Center(
                  child: Text(
                    widget.title,
                    style: GoogleFonts.syne(
                      fontSize: 25.0,
                      color: Colors.black, // Cor do texto
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
