import 'package:app_leitura/pages/initial_home.dart';
import 'package:app_leitura/pages/level_completed.dart';
import 'package:app_leitura/pages/ranking_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../pages/profile_page.dart';

class SubMenuWidget extends StatelessWidget {
  final String nameUser;

  const SubMenuWidget({
    super.key,
    required this.nameUser,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        color: Color(0xff012363),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                InitialHome(nameUser: nameUser)));
                  },
                  child: const Column(
                    children: [
                      Icon(
                        Icons.home,
                        color: Colors.white,
                      ),
                      Text(
                        'Home',
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                LevelCompletedPage(nameUser: nameUser)));
                  },
                  child: const Column(
                    children: [
                      Icon(
                        Icons.emoji_events,
                        color: Colors.white,
                      ),
                      Text(
                        'Conquistas',
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                RankingPage(nameUser: nameUser)));
                  },
                  child: const Column(
                    children: [
                      Icon(
                        FontAwesomeIcons.rankingStar,
                        color: Colors.white,
                      ),
                      Text(
                        'Ranking',
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProfilePage(nameUser: nameUser)));
                  },
                  child: const Column(
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      Text(
                        'Perfil',
                        style: TextStyle(color: Colors.white, fontSize: 13),
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
