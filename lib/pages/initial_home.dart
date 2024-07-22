import 'package:app_leitura/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_leitura/pages/weeks_page.dart';
import 'package:app_leitura/pages/card_teste.dart'; // Adicione a importação da página CardTeste
import 'package:app_leitura/widgets/button_notification.dart';
import 'package:app_leitura/widgets/button_default.dart';
import 'package:app_leitura/widgets/sub_menu_home_widget.dart';

class InitialHome extends StatelessWidget {
  final String nameUser;
  final HomeController _controller = HomeController();

  InitialHome({super.key, required this.nameUser});

  @override
  Widget build(BuildContext context) {
    final titles = _controller.extractTitles();
    final imageList = _controller.getImageList();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text('', style: TextStyle(color: Colors.black)),
          actions: [ButtonNotification(nameUser: nameUser)],
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 10),
          children: [
            _buildUserGreeting(),
            const SizedBox(height: 20),
            _buildIntroText(),
            const SizedBox(height: 10),
            _buildCarousel(imageList, titles),
            const SizedBox(height: 20),
            _buildSectionTitle('Próximas tarefas a serem liberadas'),
            const SizedBox(height: 30),
            ..._buildTaskButtons(context),
          ],
        ),
        bottomNavigationBar: MenuHomeWidget(nameUser: nameUser),
      ),
    );
  }

  Widget _buildUserGreeting() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      child: Row(
        children: [
          Text(
            'Olá, $nameUser',
            style: GoogleFonts.syne(fontSize: 20.0, color: Colors.black),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildIntroText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Você está no nível 1 - Início\n',
              style: GoogleFonts.syne(fontSize: 20.0, color: Colors.black),
            ),
            const TextSpan(text: '\n'),
            TextSpan(
              text:
                  'Esse é o seu primeiro mês de atividades, estamos felizes com seu início',
              style: GoogleFonts.syne(fontSize: 20.0, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCarousel(List<String> imageList, List<String> titles) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: 250,
        child: CustomCarousel(
          imageList: imageList,
          titles: titles,
          userName: nameUser,
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Center(
        child: Text(
          title,
          style: GoogleFonts.syne(
            fontSize: 20.0,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTaskButtons(BuildContext context) {
    const tasks = [
      {'title': 'Lista de Compras', 'asset': 'assets/backgrounds/botao1.png'},
      {'title': 'Propósito de Vida', 'asset': 'assets/backgrounds/botaook.png'},
      {'title': 'Lista de Compras', 'asset': 'assets/backgrounds/botao3.png'},
    ];

    return tasks
        .map((task) => Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: CustomButtonDefault(
                title: task['title']!,
                assetsPath: task['asset']!,
                onPressed: () {
                  if (task['title'] == 'Lista de Compras') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CardTeste(
                          nameUser: '',
                          titles: [],
                        ), // Navega para a página CardTeste
                      ),
                    );
                  } else {
                    // Adicione outras navegações aqui, se necessário
                  }
                },
                borderRadius: BorderRadius.circular(10),
                textStyle: TextStyle(color: Colors.white),
              ),
            ))
        .toList();
  }
}

class CustomCarousel extends StatefulWidget {
  final List<String> imageList;
  final List<String> titles;
  final String userName;

  const CustomCarousel({
    required this.imageList,
    required this.titles,
    super.key,
    required this.userName,
  });

  @override
  _CustomCarouselState createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.5, initialPage: 200);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pageController.jumpToPage(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemCount: widget.imageList.length,
      itemBuilder: (context, index) {
        return AnimatedBuilder(
          animation: _pageController,
          builder: (context, child) {
            double value = 0.0;
            if (_pageController.position.haveDimensions) {
              value = _pageController.page! - index;
              value = (1 - (value.abs() * 0.5)).clamp(0.0, 1.0);
            }
            return Center(
              child: SizedBox(
                height: Curves.easeOut.transform(value) * 210,
                width: MediaQuery.of(context).size.width * 0.9,
                child: child,
              ),
            );
          },
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WeeksPage(
                    nivel: widget.titles[index],
                    nameUser: widget.userName,
                    userName: '',
                    titles: null,
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 8,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Column(
                  children: [
                    Expanded(
                      child: Image.asset(
                        widget.imageList[index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.titles.length > index
                            ? widget.titles[index]
                            : 'Título não encontrado',
                        style: GoogleFonts.syne(
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
