import 'dart:convert';
import 'package:app_leitura/pages/weeks_page.dart';
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
    _loadNextWeekThemes();
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
      await _loadNextWeekThemes();
    } catch (e) {
      print('Erro ao carregar dados do Firestore: $e');
    }
  }

  Future<DateTime?> _getStartDateFromFirestore() async {
    try {
      final startDateDoc = await FirebaseFirestore.instance
          .collection('startDateWeekPhrase')
          .doc('dateStartTitleWeeks')
          .get();

      if (startDateDoc.exists) {
        final startDateString = startDateDoc.data()?['dateStart'] as String?;
        if (startDateString != null) {
          final dateComponents = startDateString.split('-');
          if (dateComponents.length == 3) {
            return DateTime(
              int.parse(dateComponents[0]),
              int.parse(dateComponents[1]),
              int.parse(dateComponents[2]),
            );
          }
        }
      }
    } catch (e) {
      print('Erro ao carregar a data de início da semana: $e');
    }
    return null;
  }


  Future<void> _loadNextWeekThemes() async {
    try {
      final startDate = await _getStartDateFromFirestore();
      if (startDate == null) {
        print('Data de início da semana não encontrada.');
        return;
      }

      DateTime today = DateTime.now();
      DateTime startOfCurrentWeek = startDate.subtract(Duration(days: startDate.weekday - 1));
      DateTime startOfNextWeek = startOfCurrentWeek.add(const Duration(days: 7));

      // Verifica se a semana atual passou
      if (today.isAfter(startOfNextWeek.subtract(const Duration(days: 1)))) {
        startOfNextWeek = startOfNextWeek.add(const Duration(days: 7));
      }

      //print('Start of next week: $startOfNextWeek'); // Depuração

      List<Map<String, String>> themesList = [];

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

          //print('Active date from Firestore: $activedata'); // Depuração

          if (activedata != null && activedata.isAfter(startOfNextWeek.subtract(const Duration(days: 1))) &&
              activedata.isBefore(startOfNextWeek.add(const Duration(days: 7)))) {
            if (weekData['active'] != true) {
              await levelRef.doc(doc.id).update({'active': true});
            }

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

            //print('Loaded themes for next week: $themes'); // Depuração
            return;
          }
        }
      }
    } catch (e) {
      print('Erro ao carregar temas da próxima semana: $e');
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
      fontSize: 18.sp,
      fontWeight: FontWeight.normal,
      color: Colors.black,
      fontFamily: 'Roboto',
    );

    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Center(child: Text('Usuário não autenticado.'));
    }

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('users').doc(user.uid).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: Colors.grey[300],
            appBar: AppBar(
              title: Text("Olá ${widget.nameUser.split(' ')[0]}", 
                style: TextStyle(fontSize: 30.sp,
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
            body: const Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            backgroundColor: Colors.grey[300],
            appBar: AppBar(
              title: Text("Olá ${widget.nameUser.split(' ')[0]}", 
                style: TextStyle(fontSize: 30.sp,
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
            body: Center(child: Text('Erro: ${snapshot.error}')),
          );
        } else if (!snapshot.hasData || !snapshot.data!.exists) {
          return Scaffold(
            backgroundColor: Colors.grey[300],
            appBar: AppBar(
              title: Text("Olá ${widget.nameUser.split(' ')[0]}", 
                style: TextStyle(fontSize: 30.sp,
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
            body: const Center(child: Text('Nome do usuário não encontrado.')),
          );
        } else {
          final userData = snapshot.data!.data() as Map<String, dynamic>;
          final userName = userData['name'] as String? ?? widget.nameUser;

          return Scaffold(
            backgroundColor: Colors.grey[300],
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            appBar: AppBar(
              title: Text("Olá ${userName.split(' ')[0]}", 
                style: TextStyle(fontSize: 30.sp,
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
                ButtonNotification(nameUser: userName),
                const SizedBox(width: 16),
              ],
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),
                      Text(
                        "Seja bem-vindo ao seu desafio.",
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Text(
                        "Celebre suas vitórias e continue avançando!",
                        style: regularTextStyle,
                      ),
                      SizedBox(height: 40.h),
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
                      children: currentWeekThemes.isEmpty
                        ? [const Center(child: Text('Nenhum tema disponível para a próxima semana.'))]
                        : currentWeekThemes.map((theme) {
                            return MyListTile(
                              inconImagePath: theme['iconPath'] ?? "assets/backgrounds/botao1.png",
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
            bottomNavigationBar: SubMenuWidget(nameUser: userName),
          );
        }
      },
    );
  }
}
