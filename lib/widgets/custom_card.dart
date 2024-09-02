import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String imagePath;

  const CustomCard({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Image.asset(
              imagePath,
              height: 120,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            "Teste",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 6,
          ),
          const Text(
            "Teste",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          )
        ]),
      ),
    );
  }
}
