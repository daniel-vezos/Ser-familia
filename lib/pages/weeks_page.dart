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

class WeeksPage extends StatefulWidget {
  final String nivel;
  final String nameUser;

  const WeeksPage({
    super.key,
    required this.nivel,
    required this.nameUser,
    required String userName,
    required titles,
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

  void _loadWeeks() {
    try {
      Map<String, dynamic> jsonData = json.decode(weeks);
      Map<String, dynamic> selectedLevel = jsonData[widget.nivel];

      themesByWeek = selectedLevel.map((key, value) {
        return MapEntry(key, List<Map<String, dynamic>>.from(value));
      });

      setState(() {
        semanas = selectedLevel.keys.toList();
      });
    } catch (e) {
      print('Erro ao carregar semanas: $e');
      // Handle JSON parsing error
    }
  }

  @override
  Widget build(BuildContext context) {
    // Configuração do ScreenUtil
    ScreenUtil.init(
      context,
      designSize:
          const Size(375, 820), // Tamanho base para as resoluções móveis
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
                    nameUser: widget.nameUser,
                  ),
                ),
              );
            },
            borderRadius: BorderRadius.circular(15),
            textStyle: buttonStyle, // Aplica o estilo do texto ao botão
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
      backgroundColor: Colors.grey[300], // Define a cor de fundo
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        actions: [
          PointsCard(userId: user.uid),
          SizedBox(width: 16.w),
          ButtonNotification(nameUser: widget.nameUser),
          SizedBox(width: 16.w),
        ],
      ),

      body: Container(
        color:
            Colors.grey[300], // Garante que toda a área de rolagem esteja cinza
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
                      "Olá ${widget.nameUser.split(' ')[0]}",
                      style: headerStyle,
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Text(
                  'ATIVIDADES SEMANAIS',
                  style: headerStyle.copyWith(
                      fontSize: 20
                          .sp), // Ajuste o tamanho da fonte para responsividade
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
      bottomNavigationBar: SubMenuWidget(nameUser: widget.nameUser),
    );
  }
}
