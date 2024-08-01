import 'package:flutter/material.dart';
import 'package:app_leitura/pages/page_tasks.dart';
import 'package:app_leitura/widgets/button_notification.dart';
import 'package:app_leitura/widgets/points_card.dart';
import 'package:app_leitura/widgets/sub_menu_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil

class PageTheme extends StatelessWidget {
  final String nameUser;
  final String weekTitle;
  final List<Map<String, dynamic>> themes;

  const PageTheme({
    super.key,
    required this.weekTitle,
    required this.themes,
    required this.nameUser,
  });

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Center(child: Text('Usuário não autenticado.'));
    }

    // Configuração do ScreenUtil
    ScreenUtil.init(
      context,
      designSize:
          const Size(375, 820), // Tamanho base para as resoluções móveis
      minTextAdapt: true,
    );

    final TextStyle buttonStyle = TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.normal, // Ajuste o peso da fonte para normal
      color: Colors.black,
      fontFamily: 'Roboto', // Define a fonte Roboto
    );

    final TextStyle headerStyle = TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.normal, // Ajuste o peso da fonte para normal
      color: Colors.black,
      fontFamily: 'Roboto', // Define a fonte Roboto
    );

    final TextStyle titleStyle = TextStyle(
      fontSize: 25.sp,
      color: Colors.black,
      fontFamily: 'Roboto', // Define a fonte Roboto
    );

    List<Widget> themeButtons = themes.map((theme) {
      final iconPath = theme['iconpath'] ?? ''; // Obtém o caminho da imagem

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
                width: MediaQuery.of(context).size.width *
                    0.8, // 80% da largura da tela
                child: ElevatedButton(
                  onPressed: () {
                    final title = theme['title'] ?? 'Sem Título';
                    final challenge = theme['challenge'] ?? 'Sem Descrição';
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PageTasks(
                          title: title,
                          challenge: challenge,
                          nameUser: nameUser,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.grey[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    textStyle: buttonStyle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        iconPath.isNotEmpty
                            ? Image.asset(
                                iconPath,
                              )
                            : Container(),
                            const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            theme['title'] ?? 'Sem Título',
                            style:
                                const TextStyle(fontSize: 20, color: Colors.black),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 15.h),
        ],
      );
    }).toList();

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          PointsCard(userId: user.uid),
          SizedBox(width: 16.w),
          ButtonNotification(nameUser: nameUser),
          SizedBox(width: 16.w),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Olá ${nameUser.split(' ')[0]}",
                  style: headerStyle,
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Text(
              weekTitle,
              style: titleStyle,
            ),
            SizedBox(height: 20.h),
            Column(
              children: themeButtons,
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
      bottomNavigationBar: SubMenuWidget(nameUser: nameUser),
    );
  }
}
