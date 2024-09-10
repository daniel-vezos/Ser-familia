import 'package:app_leitura/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:app_leitura/pages/initial_home.dart';
import 'package:app_leitura/pages/level_completed.dart';
import 'package:app_leitura/pages/ranking_page.dart';

class SubMenuWidget extends StatelessWidget {
  final String nameUser;
  final VoidCallback? onMenuOpen;

  const SubMenuWidget({
    super.key,
    required this.nameUser,
    this.onMenuOpen,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: 70, // Ajuste a altura conforme necessário para mais espaço
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          color: Color(0xff012363),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Wrap(
            alignment: WrapAlignment.spaceAround,
            spacing: 5,
            children: [
              _buildMenuItem(
                context,
                Icons.home,
                'Home',
                () {
                  _handleMenuOpen(
                    context,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InitialHome(nameUser: nameUser),
                      ),
                    ),
                  );
                },
              ),
              _buildMenuItem(
                context,
                Icons.emoji_events,
                'Conquistas',
                () {
                  _handleMenuOpen(
                    context,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            LevelCompletedPage(nameUser: nameUser),
                      ),
                    ),
                  );
                },
              ),
              _buildMenuItem(
                context,
                FontAwesomeIcons.rankingStar,
                'Ranking',
                () {
                  _handleMenuOpen(
                    context,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RankingPage(nameUser: nameUser),
                      ),
                    ),
                  );
                },
              ),
              _buildMenuItem(
                context,
                Icons.person,
                'Perfil',
                () {
                  _handleMenuOpen(
                    context,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfilePage(nameUser: nameUser),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleMenuOpen(BuildContext context, VoidCallback onTap) {
    if (onMenuOpen != null) {
      onMenuOpen!();
    }
    onTap();
  }

  Widget _buildMenuItem(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: () => _handleMenuOpen(context, onTap),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.22,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
                height:
                    10), // Espaço adicionado entre o topo da barra e o ícone
            Icon(
              icon,
              color: Colors.white,
              size: 24, // Tamanho ajustado para ícone
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
              ),
              textAlign: TextAlign.center, // Centraliza o texto
            ),
          ],
        ),
      ),
    );
  }
}
