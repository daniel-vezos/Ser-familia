import 'package:app_leitura/widgets/points_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import '../widgets/button_notification.dart';
import '../widgets/button_default.dart';
import '../widgets/sub_menu_widget.dart';
import 'page_theme.dart';
import 'package:app_leitura/data/weeks_data.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WeeksPage extends StatefulWidget {
  final String nivel;
  final String userName;
  final List<dynamic> titles;

  const WeeksPage({
    super.key,
    required this.nivel,
    required this.userName,
    required this.titles,
  });

  @override
  State<WeeksPage> createState() => _WeeksPageState();
}

class _WeeksPageState extends State<WeeksPage> {
  late Map<String, List<Map<String, dynamic>>> themesByWeek = {};
  List<String> semanas = [];

  @override
  void initState() {
    super.initState();
    _loadWeeks();
  }

  Future<void> _loadWeeks() async {
    try {
      final levelRef = FirebaseFirestore.instance.collection('levels').doc(widget.nivel).collection('weeks');
      final querySnapshot = await levelRef.get();

      final Map<String, List<Map<String, dynamic>>> tempThemesByWeek = {};
      final List<String> tempSemanas = [];
      final DateTime now = DateTime.now();
      final DateTime today = DateTime(now.year, now.month, now.day); // Apenas o dia atual sem a parte da hora

      for (var doc in querySnapshot.docs) {
        final weekData = doc.data();
        final weekTitle = doc.id;

        // Converte a data de ativação para DateTime
        final activedataString = weekData['activedata'] as String?;
        DateTime? activedata;

        if (activedataString != null) {
          try {
            final activedataComponents = activedataString.split('-');
            if (activedataComponents.length == 3) {
              activedata = DateTime(
                int.parse(activedataComponents[0]), // Ano
                int.parse(activedataComponents[1]), // Mês
                int.parse(activedataComponents[2]), // Dia
              );
            }
          } catch (e) {
            print('Erro ao analisar activedata: $e');
            continue; // Pule para o próximo documento se houver um erro na análise
          }
        }

        if (activedata != null && (today.isAfter(activedata) || today.isAtSameMomentAs(activedata))) {
          // Atualiza o campo 'active' para true se a data atual for igual ou após a data de ativação
          if (weekData['active'] != true) {
            await levelRef.doc(weekTitle).update({'active': true});
          }

          // Só adicione a semana se estiver ativa
          tempSemanas.add(weekTitle);

          final themeCollection = FirebaseFirestore.instance
              .collection('levels')
              .doc(widget.nivel)
              .collection('weeks')
              .doc(weekTitle)
              .collection('themes');

          final themeQuerySnapshot = await themeCollection.get();
          final List<Map<String, dynamic>> themes = themeQuerySnapshot.docs.map((doc) => doc.data()).toList();

          tempThemesByWeek[weekTitle] = themes;
        }
      }

      setState(() {
        themesByWeek = tempThemesByWeek;
        semanas = tempSemanas;
      });
    } catch (e) {
      print('Erro ao carregar semanas: $e');
      // Handle error appropriately
    }
  }


  @override
  Widget build(BuildContext context) {
    // Configuração do ScreenUtil
    ScreenUtil.init(
      context,
      designSize: const Size(375, 820),
      minTextAdapt: true,
    );

    final TextStyle buttonStyle = TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    );

    final TextStyle headerStyle = TextStyle(
      fontSize: 19.sp,
      fontWeight: FontWeight.normal,
      color: Colors.black,
      fontFamily: 'Roboto',
    );

    List<Widget> buttons = semanas.map((titulo) {
      return Column(
        children: [
          CustomButtonDefault(
            title: titulo,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PageTheme(
                    weekTitle: titulo,
                    themes: themesByWeek[titulo] ?? [],
                    nameUser: widget.userName,
                  ),
                ),
              );
            },
            borderRadius: BorderRadius.circular(15),
            textStyle: buttonStyle,
          ),
          SizedBox(height: 20.h),
        ],
      );
    }).toList();

    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Center(child: Text('Usuário não autenticado.'));
    }

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        actions: [
          PointsCard(userId: user.uid),
          SizedBox(width: 16.w),
          ButtonNotification(nameUser: widget.userName),
          SizedBox(width: 16.w),
        ],
      ),
      body: Container(
        color: Colors.grey[300],
        child: ListView(
          padding: EdgeInsets.all(20.w),
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Olá ${widget.userName.split(' ')[0]}",
                      style: headerStyle,
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Text(
                  'ATIVIDADES SEMANAIS',
                  style: headerStyle.copyWith(
                      fontSize: 20.sp),
                ),
                SizedBox(height: 20.h),
                Column(
                  children: buttons,
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: SubMenuWidget(nameUser: widget.userName),
    );
  }
}
