import 'package:app_leitura/pages/initial_home.dart';
import 'package:app_leitura/pages/profile_page.dart';
import 'package:flutter/material.dart';

class SubMenuDefaultWidget extends StatelessWidget {
  const SubMenuDefaultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 1, 35, 99),
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  String nomeDoUsuario = "Nome do Usuário"; // Substitua pelo nome real do usuário
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InitialHome(name: nomeDoUsuario))
                  );
                },
                child: const Column(
                  children: [
                    Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    Text(
                      'Home',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {},
                child: const Column(
                  children: [
                    Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    Text(
                      'Pesquisar',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProfilePage())
                  );
                },
                child: const Column(
                  children: [
                    Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    Text(
                      'Perfil',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
