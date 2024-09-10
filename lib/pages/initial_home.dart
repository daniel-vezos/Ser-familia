import 'dart:convert';
import 'package:app_leitura/pages/app_bar_icons.dart';
import 'package:app_leitura/pages/page_tasks.dart';
import 'package:app_leitura/pages/weeks_page.dart';
import 'package:app_leitura/widgets/button_notification.dart';
import 'package:app_leitura/widgets/points_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_leitura/util/my_card.dart';
import 'package:app_leitura/util/my_list_tile.dart';
import 'package:app_leitura/widgets/sub_menu_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class InitialHome extends StatefulWidget {
  final String nameUser;

  const InitialHome({super.key, required this.nameUser});

  @override
  InitialHomeState createState() => InitialHomeState();
}

class InitialHomeState extends State<InitialHome> {
  final PageController _controller = PageController();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  Map<String, dynamic> weeksData = {};
  List<Map<String, String>> currentWeekThemes = [];
  int _notificationCount = 0;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    _loadWeeksData();
    _configureFirebaseMessaging();
  }

  Future<void> _configureFirebaseMessaging() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      setState(() => _notificationCount++);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      setState(() => _notificationCount++);
    });

    final initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      setState(() => _notificationCount++);
    }
  }

  Future<void> _loadWeeksData() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('levels').get();
      setState(() {
        weeksData = {for (var doc in snapshot.docs) doc.id: doc.data()};
      });
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
          return DateTime.parse(dateComponents.join('-'));
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
      DateTime startOfCurrentWeek =
          startDate.subtract(Duration(days: startDate.weekday - 1));
      DateTime startOfNextWeek =
          startOfCurrentWeek.add(const Duration(days: 7));

      if (today.isAfter(startOfNextWeek.subtract(const Duration(days: 1)))) {
        startOfNextWeek = startOfNextWeek.add(const Duration(days: 7));
      }

      for (var levelName in weeksData.keys) {
        final levelRef = FirebaseFirestore.instance
            .collection('levels')
            .doc(levelName)
            .collection('weeks');
        final querySnapshot = await levelRef.get();

        for (var doc in querySnapshot.docs) {
          final weekData = doc.data();
          final activedataString = weekData['activedata'] as String?;
          DateTime? activedata = activedataString != null
              ? DateTime.parse(activedataString)
              : null;

          if (activedata != null &&
              activedata
                  .isAfter(startOfNextWeek.subtract(const Duration(days: 1))) &&
              activedata
                  .isBefore(startOfNextWeek.add(const Duration(days: 7)))) {
            if (weekData['active'] != true) {
              await levelRef.doc(doc.id).update({'active': true});
            }

            final themeCollection = levelRef.doc(doc.id).collection('themes');
            final themeQuerySnapshot = await themeCollection.get();

            setState(() {
              currentWeekThemes = themeQuerySnapshot.docs.map((doc) {
                final data = doc.data();
                return {
                  'title': data['title'] as String? ?? 'Sem título',
                  'iconPath': data.containsKey('iconPath')
                      ? data['iconPath'] as String
                      : 'assets/backgrounds/botao1.png',
                  'challenge': data.containsKey('challenge')
                      ? data['challenge'] as String
                      : 'Sem descrição',
                };
              }).toList();
            });

            return;
          }
        }
      }
    } catch (e) {
      print('Erro ao carregar temas da próxima semana: $e');
    }
  }

  Widget _buildLevelCard(String levelName, int levelNumber) {
    bool clickable = true; // placeholder for isCardClickable logic
    String backgroundImagePath =
        'assets/backgrounds/trofeu.png'; // Definir valor padrão

    return FutureBuilder(
      future: _fetchBackgroundImagePath(levelName),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          backgroundImagePath = snapshot.data as String;
        }
        return MyCard(
          imagePath: backgroundImagePath,
          title: levelName,
          onPressed: clickable ? () => _navigateToWeeksPage(levelName) : null,
          color: clickable ? Colors.white : Colors.grey.withOpacity(0.5),
        );
      },
    );
  }

  Future<String> _fetchBackgroundImagePath(String levelName) async {
    try {
      final levelDoc = await FirebaseFirestore.instance
          .collection('levels')
          .doc(levelName)
          .get();
      if (levelDoc.exists) {
        final levelData = levelDoc.data();
        return levelData != null && levelData.containsKey('backgroundLevel')
            ? levelData['backgroundLevel'] as String
            : "assets/backgrounds/trofeu.png";
      }
    } catch (e) {
      print('Erro ao carregar o caminho da imagem: $e');
    }
    return "assets/backgrounds/trofeu.png";
  }

  void _navigateToWeeksPage(String levelName) {
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
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: const Size(375, 820), minTextAdapt: true);

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

    return FutureBuilder<DocumentSnapshot>(
      future:
          FirebaseFirestore.instance.collection('users').doc(user.uid).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingScreen();
        } else if (snapshot.hasError) {
          return _buildErrorScreen(snapshot.error.toString());
        } else if (!snapshot.hasData || !snapshot.data!.exists) {
          return _buildUserNotFoundScreen();
        } else {
          final userData = snapshot.data!.data() as Map<String, dynamic>;
          final userName = userData.containsKey('name')
              ? userData['name'] as String
              : widget.nameUser;
          return _buildMainScreen(userName);
        }
      },
    );
  }

  Scaffold _buildLoadingScreen() {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: _buildAppBar(),
      body: const Center(child: CircularProgressIndicator()),
    );
  }

  Scaffold _buildErrorScreen(String error) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: _buildAppBar(),
      body: Center(child: Text('Erro: $error')),
    );
  }

  Scaffold _buildUserNotFoundScreen() {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: _buildAppBar(),
      body: const Center(child: Text('Nome do usuário não encontrado.')),
    );
  }

  Scaffold _buildMainScreen(String userName) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: _buildAppBar(),
      body: _buildContent(userName),
      bottomNavigationBar: SubMenuWidget(nameUser: userName),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        "Olá ${widget.nameUser.split(' ')[0]}",
        style: TextStyle(
          fontSize: 30.sp,
          fontWeight: FontWeight.w500,
          fontFamily: 'Roboto',
        ),
      ),
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        PointsCard(userId: FirebaseAuth.instance.currentUser?.uid ?? ''),
        myAppBarIcon(context, _notificationCount),
        const SizedBox(width: 16),
      ],
    );
  }

  Widget _buildContent(String userName) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildWelcomeText(),
              _buildLevelCards(),
              _buildUpcomingTasks(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
          style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.normal,
              color: Colors.black,
              fontFamily: 'Roboto'),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }

  Widget _buildLevelCards() {
    return Column(
      children: [
        SizedBox(
          height: 220.h,
          child: PageView(
            scrollDirection: Axis.horizontal,
            controller: _controller,
            children: weeksData.keys
                .map((level) =>
                    _buildLevelCard(level, int.parse(level.split(' ')[1])))
                .toList(),
          ),
        ),
        SizedBox(height: 20.h),
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
        SizedBox(height: 30.h),
      ],
    );
  }

  Widget _buildUpcomingTasks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Text(
            "Próximas tarefas a serem liberadas",
            style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.normal,
                color: Colors.black,
                fontFamily: 'Roboto'),
          ),
        ),
        SizedBox(height: 20.h),
        currentWeekThemes.isEmpty
            ? const Center(
                child: Text('Nenhum tema disponível para a próxima semana.'))
            : Column(children: buildThemeButtons()),
      ],
    );
  }

  List<Widget> buildThemeButtons() {
    return currentWeekThemes.map((theme) {
      final iconPath = theme['iconPath'] ?? '';
      final title = theme['title'] ?? 'Sem Título';
      final challenge = theme['challenge'] ?? 'Sem Descrição';

      return Column(
        children: [
          Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey[200],
              ),
              child: SizedBox(
                height: 60.h,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      if (iconPath.isNotEmpty)
                        Image.asset(
                          iconPath,
                          height: 30.h,
                          fit: BoxFit.contain,
                        ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10.h),
        ],
      );
    }).toList();
  }
}
