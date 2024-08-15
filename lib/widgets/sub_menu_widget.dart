import 'package:app_leitura/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:app_leitura/pages/initial_home.dart';
import 'package:app_leitura/pages/level_completed.dart';
import 'package:app_leitura/pages/ranking_page.dart';

class SubMenuWidget extends StatelessWidget {
  final String nameUser;
  final VoidCallback? onMenuOpen; // Adicionado o parâmetro opcional

  const SubMenuWidget({
    super.key,
    required this.nameUser,
    this.onMenuOpen, // Inicializado o parâmetro
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isWide =
              constraints.maxWidth > 800; // Ajuste o valor conforme necessário

          return Container(
            width: double.infinity,
            height: 70,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              color: Color(0xff012363),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: isWide
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildMenuItem(
                          context,
                          Icons.home,
                          'Home',
                          () {
                            _handleMenuOpen(context, () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    InitialHome(nameUser: nameUser),
                              ),
                            ));
                          },
                        ),
                        _buildMenuItem(
                          context,
                          Icons.emoji_events,
                          'Conquistas',
                          () {
                            _handleMenuOpen(context, () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    LevelCompletedPage(nameUser: nameUser),
                              ),
                            ));
                          },
                        ),
                        _buildMenuItem(
                          context,
                          FontAwesomeIcons.rankingStar,
                          'Ranking',
                          () {
                            _handleMenuOpen(context, () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    RankingPage(nameUser: nameUser),
                              ),
                            ));
                          },
                        ),
                        _buildMenuItem(
                          context,
                          Icons.person,
                          'Perfil',
                          () {
                            _handleMenuOpen(context, () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProfilePage(nameUser: nameUser),
                              ),
                            ));
                          },
                        ),
                      ],
                    )
                  : Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 30,
                      runSpacing: 20,
                      children: [
                        _buildMenuItem(
                          context,
                          Icons.home,
                          'Home',
                          () {
                            _handleMenuOpen(context, () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    InitialHome(nameUser: nameUser),
                              ),
                            ));
                          },
                        ),
                        _buildMenuItem(
                          context,
                          Icons.emoji_events,
                          'Conquistas',
                          () {
                            _handleMenuOpen(context, () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    LevelCompletedPage(nameUser: nameUser),
                              ),
                            ));
                          },
                        ),
                        _buildMenuItem(
                          context,
                          FontAwesomeIcons.rankingStar,
                          'Ranking',
                          () {
                            _handleMenuOpen(context, () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    RankingPage(nameUser: nameUser),
                              ),
                            ));
                          },
                        ),
                        _buildMenuItem(
                          context,
                          Icons.person,
                          'Perfil',
                          () {
                            _handleMenuOpen(context, () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProfilePage(nameUser: nameUser),
                              ),
                            ));
                          },
                        ),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }

  void _handleMenuOpen(BuildContext context, VoidCallback onTap) {
    if (onMenuOpen != null) {
      onMenuOpen!(); // Chama o callback se fornecido
    }
    onTap(); // Executa a ação do menu
  }

  Widget _buildMenuItem(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: () => _handleMenuOpen(context, onTap),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 15),
          Icon(
            icon,
            color: Colors.white,
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
