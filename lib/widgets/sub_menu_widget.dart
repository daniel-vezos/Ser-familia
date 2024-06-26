import 'package:flutter/material.dart';

class SubMenuDefaultWidget extends StatelessWidget {
  const SubMenuDefaultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 1, 35, 99),
      height: 70,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.home, color: Colors.white),
              SizedBox(height: 4),
              Text(
                'Home',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.search, color: Colors.white),
              SizedBox(height: 4),
              Text(
                'Pesquisar',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.person, color: Colors.white),
              SizedBox(height: 4),
              Text(
                'Perfil',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
