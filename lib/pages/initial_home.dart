import 'package:app_leitura/pages/weeks_page.dart';
import 'package:app_leitura/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/button_default.dart';
import '../widgets/sub_menu_home_widget.dart';

void main() {
  runApp(InitialHome());
}

class InitialHome extends StatelessWidget {
  InitialHome({super.key});

  final List<String> _imageList = [
    "assets/cards/1.png",
    "assets/cards/2.png",
    "assets/cards/3.png",
    "assets/cards/4.png",
    "assets/cards/5.png",
    "assets/cards/6.png",
    "assets/cards/7.png",
    "assets/cards/8.png",
    "assets/cards/9.png",
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(elevation: 0),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 10),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12.0, 0, 12.0, 4.0),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Olá, Aluno\n',
                      style:
                          GoogleFonts.syne(fontSize: 20.0, color: Colors.black),
                    ),
                    const TextSpan(text: '\n'),
                    TextSpan(
                      text: 'Você está no nível 1 - Início\n',
                      style:
                          GoogleFonts.syne(fontSize: 20.0, color: Colors.black),
                    ),
                    const TextSpan(text: '\n'),
                    TextSpan(
                      text:
                          'Esse é o seu primeiro mês de atividades, estamos felizes com seu início',
                      style:
                          GoogleFonts.syne(fontSize: 20.0, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: 200,
                child: Carousel(imageList: _imageList),
              ),
            ),
            const SizedBox(height: 30),
            _buildSectionTitle('Próximas tarefas a serem liberadas'),
            const SizedBox(height: 30),
            CustomButtonDefault(
                title: 'Lista de Compras', 
                assetsPath: 'assets/backgrounds/botao1.png',
                onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const WeeksPage()));
                },
            ),
            const SizedBox(height: 20),
            CustomButtonDefault(
                title: 'Propósito de Vida',
                assetsPath: 'assets/backgrounds/botaook.png',
                onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const WeeksPage()));
                },
            ),
            const SizedBox(height: 20),
            CustomButtonDefault(
                title: 'Lista de Compras',
                assetsPath: 'assets/backgrounds/botao3.png',
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const WeeksPage()));
                },
            ),
            const SizedBox(height: 30),
          ],
        ),
        bottomNavigationBar: const MenuHomeWidget(),
      ),
    );
  }

  Padding _buildSectionTitle(String title) {
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
}

class Carousel extends StatefulWidget {
  final List<String> imageList;

  const Carousel({required this.imageList, super.key});

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.3);
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
                height: Curves.easeOut.transform(value) * 200,
                width: MediaQuery.of(context).size.width *
                    0.9, // Adjust width here
                child: child,
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            width: MediaQuery.of(context).size.width * 8, // Adjust width here
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromARGB(255, 255, 255, 255),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                widget.imageList[index],
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
    );
  }
}