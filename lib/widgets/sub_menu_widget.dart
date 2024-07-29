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
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: 70,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          color: Color(0xff012363),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18)
              .copyWith(top: 10), // Adicione o espaçamento desejado aqui
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            spacing: 8, // Espaçamento entre os itens
            children: [
              _buildMenuItem(
                context,
                Icons.home,
                'Home',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InitialHome(nameUser: nameUser),
                  ),
                ),
              ),
              _buildMenuItem(
                context,
                Icons.emoji_events,
                'Conquistas',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        LevelCompletedPage(nameUser: nameUser),
                  ),
                ),
              ),
              _buildMenuItem(
                context,
                FontAwesomeIcons.rankingStar,
                'Ranking',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RankingPage(nameUser: nameUser),
                  ),
                ),
              ),
              _buildMenuItem(
                context,
                Icons.person,
                'Perfil',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(nameUser: nameUser),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
