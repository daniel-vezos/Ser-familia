import 'package:app_leitura/pages/ranking_page.dart';
import 'package:flutter/material.dart';

import '../pages/profile_page.dart';

class MenuHomeWidget extends StatelessWidget {
  const MenuHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 1, 35, 99),
      height: 70,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RankingPage())
                    );
                  },
                  child: const Column(
                    children: [
                      Icon(
                        Icons.emoji_events,
                        color: Colors.white,
                      ),
                      Text(
                        'Conquistas',
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
      ),
    );
  }
}
