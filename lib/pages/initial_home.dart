import 'package:app_leitura/pages/weeks_page.dart';
import 'package:app_leitura/widgets/button_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:app_leitura/util/my_card.dart';
import 'package:app_leitura/util/my_list_tile.dart';
import 'package:app_leitura/widgets/sub_menu_widget.dart';

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

  @override
  Widget build(BuildContext context) {
    // Configuração do ScreenUtil
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

    return Scaffold(
      backgroundColor: Colors.grey[300],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
                  "Você está no nível 1 - início.",
                  style: regularTextStyle,
                ),
                SizedBox(height: 15.h),
                Text(
                  "Esse é o seu primeiro mês de atividades, estamos felizes com seu início!",
                  style: regularTextStyle,
                ),
                SizedBox(height: 30.h),
                SizedBox(
                  height: 260.h, // Ajuste a altura mínima conforme necessário
                  child: PageView(
                    scrollDirection: Axis.horizontal,
                    controller: _controller,
                    children: [
                      _buildCard('Nível 1', 'assets/backgrounds/trofeu1.png'),
                      _buildCard('Nível 2', 'assets/backgrounds/trofeu1.png'),
                      _buildCard('Nível 3', 'assets/backgrounds/trofeu1.png'),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                Center(
                  child: SmoothPageIndicator(
                    controller: _controller,
                    count: 3,
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
                  children: [
                    const MyListTile(
                      inconImagePath: "assets/backgrounds/botao1.png",
                      tileTile: "Gratidão",
                      onTap: null,
                      tilesubTile: '',
                    ),
                    SizedBox(height: 20.h),
                    const MyListTile(
                      inconImagePath: "assets/backgrounds/botao1.png",
                      tileTile: "Propósito de Vida",
                      tilesubTile: "",
                      onTap: null,
                    ),
                    SizedBox(height: 20.h),
                    const MyListTile(
                      inconImagePath: "assets/backgrounds/botao1.png",
                      tileTile: "Lista de Compras",
                      tilesubTile: "",
                      onTap: null,
                    ),
                  ],
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

  // Helper method to create a card
  Widget _buildCard(String title, String imagePath) {
    return AspectRatio(
      aspectRatio: 100 / 100, // Ajuste o aspecto conforme necessário
      child: MyCard(
        imagePath: imagePath,
        title: title,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WeeksPage(
                nameUser: widget.nameUser,
                nivel: '$title Conquista',
                userName: widget.nameUser,
                titles: null,
              ),
            ),
          );
        },
      ),
    );
  }
}
