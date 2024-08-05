import 'dart:convert';
import 'package:app_leitura/pages/weeks_page.dart';
import 'package:app_leitura/widgets/button_notification.dart';
import 'package:app_leitura/widgets/button_notification.dart';
import 'package:app_leitura/widgets/points_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_leitura/util/my_card.dart';
import 'package:app_leitura/util/my_list_tile.dart';
import 'package:app_leitura/widgets/sub_menu_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class InitialHome extends StatefulWidget {
  final String nameUser;

  const InitialHome({
    super.key,
    required this.nameUser,
  });

  @override
  InitialHomeState createState() => InitialHomeState();
}

class InitialHomeState extends State<InitialHome> {
  final PageController _controller = PageController();
  late Map<String, dynamic> weeksData = {};
  List<Map<String, String>> currentWeekThemes = []; // Lista de mapas com ícone e título

  @override
  void initState() {
    super.initState();
    _loadWeeksData();
  }

  Future<void> _loadWeeksData() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('levels').get();
      final data = snapshot.docs.fold<Map<String, dynamic>>({}, (map, doc) {
        map[doc.id] = doc.data();
        return map;
      });

      setState(() {
        weeksData = data;
      });

      // Load current week themes
      await _loadCurrentWeekThemes();
    } catch (e) {
      print('Erro ao carregar dados do Firestore: $e');
    }
  }

  Future<void> _loadCurrentWeekThemes() async {
    try {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);

      List<Map<String, String>> themesList = [];

      // Find the current active week
      for (var levelName in weeksData.keys) {
        final levelRef = FirebaseFirestore.instance.collection('levels').doc(levelName).collection('weeks');
        final querySnapshot = await levelRef.get();

        for (var doc in querySnapshot.docs) {
          final weekData = doc.data();
          final activedataString = weekData['activedata'] as String?;
          DateTime? activedata;

          if (activedataString != null) {
            final activedataComponents = activedataString.split('-');
            if (activedataComponents.length == 3) {
              activedata = DateTime(
                int.parse(activedataComponents[0]),
                int.parse(activedataComponents[1]),
                int.parse(activedataComponents[2]),
              );
            }
          }

          if (activedata != null && (today.isAfter(activedata) || today.isAtSameMomentAs(activedata))) {
            // Update the active status
            if (weekData['active'] != true) {
              await levelRef.doc(doc.id).update({'active': true});
            }

            // Load themes for the active week
            final themeCollection = levelRef.doc(doc.id).collection('themes');
            final themeQuerySnapshot = await themeCollection.get();
            final List<Map<String, String>> themes = themeQuerySnapshot.docs.map((doc) {
              final data = doc.data();
              return {
                'title': data['title'] as String? ?? 'Sem título',
                'iconPath': data['iconPath'] as String? ?? 'assets/backgrounds/botao1.png',
              };
            }).toList();

            setState(() {
              currentWeekThemes = themes;
            });

            return; // Exit the loop once we find the current week
          }
        }
      }
    } catch (e) {
      print('Erro ao carregar temas da semana atual: $e');
    }
  }

  bool isCardClickable(int levelNumber) {
    // Simplesmente habilita todos os cartões
    return true;
  }

  List<Widget> buildLevelCards() {
    List<Widget> levelCards = [];

    for (var level in weeksData.keys) {
      int levelNumber = int.tryParse(level.split(' ')[1]) ?? 0;
      levelCards.add(buildLevelCard(level, levelNumber));
    }

    return levelCards;
  }

  Widget buildLevelCard(String levelName, int levelNumber) {
    bool clickable = isCardClickable(levelNumber);
    return MyCard(
      imagePath: 'assets/backgrounds/trofeu1.png',
      title: levelName,
      onPressed: clickable ? () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WeeksPage(
              nivel: levelName,
              userName: widget.nameUser,
              titles: weeksData[levelName] is List ? weeksData[levelName] : [],
            ),
          ),
        );
      } : null,
      color: clickable ? Colors.white : Colors.grey.withOpacity(0.5),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(375, 820),
      minTextAdapt: true,
    );

    final TextStyle regularTextStyle = TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.normal,
      color: Colors.black,
      fontFamily: 'Roboto',
    );

    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Center(child: Text('Usuário não autenticado.'));
    }

    return Scaffold(
      backgroundColor: Colors.grey[300],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        title: Text("Olá ${widget.nameUser.split(' ')[0]}", 
          style: TextStyle(fontSize: 25.sp,
          fontWeight: FontWeight.w500,
          fontFamily: 'Roboto',
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          PointsCard(userId: user.uid),
          const SizedBox(width: 16),
          ButtonNotification(nameUser: widget.nameUser),
          const SizedBox(width: 16),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Olá ${widget.nameUser.split(' ')[0]}",
                          style: TextStyle(
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          shape: BoxShape.circle,
                        ),
                        child: ButtonNotification(nameUser: widget.nameUser),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  "Seja bem-vindo ao seu desafio.",
                  style: regularTextStyle,
                ),
                SizedBox(height: 15.h),
                Text(
                  "Celebre suas vitórias e continue avançando!",
                  style: regularTextStyle,
                ),
                SizedBox(height: 30.h),
                SizedBox(
                  height: 260.h, // Ajuste a altura mínima conforme necessário
                  child: PageView(
                    scrollDirection: Axis.horizontal,
                    controller: _controller,
                    children: buildLevelCards(),
                  ),
                ),
                SizedBox(height: 30.h),
                Center(
                  child: SmoothPageIndicator(
                    controller: _controller,
                    count: weeksData.keys.length,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: const Color.fromARGB(255, 13, 61, 144),
                      dotHeight: 8.h,
                      dotWidth: 8.w,
                      spacing: 10.w,
                    ),
                  ),
                ),
                SizedBox(height: 40.h),
                Center(
                  child: Text(
                    "Próximas tarefas a serem liberadas",
                    style: regularTextStyle,
                  ),
                ),
                SizedBox(height: 20.h),
                Column(
                  children: currentWeekThemes.map((theme) {
                    return MyListTile(
                      inconImagePath: theme['iconPath'] ?? "assets/backgrounds/botao3.png", // Usa o caminho do ícone
                      tileTile: theme['title'] ?? 'Sem título',
                    );
                  }).toList(),
                ),
                SizedBox(height: 50.h),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SubMenuWidget(nameUser: widget.nameUser),
    );
  }
}
