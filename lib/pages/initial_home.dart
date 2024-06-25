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
    "assets/backgrounds/teste.png",
    "assets/backgrounds/teste2.png",
    "assets/backgrounds/teste3.png",
    "assets/backgrounds/teste4.png",
    "assets/backgrounds/teste6.png",
    "assets/backgrounds/teste7.png",
    "assets/backgrounds/teste8.png",
    "assets/backgrounds/teste88.png",
    "assets/backgrounds/teste99.png",
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Olá, Aluno',
                          style: GoogleFonts.syne(
                              fontSize: 20.0, color: Colors.black),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.notifications,
                            size: 30.0, color: Colors.black),
                        onPressed: () {
                          // Ação ao pressionar o ícone de sino
                        },
                      ),
                    ],
                  ),
                  Text(
                    'Você está no nível 1 - Início',
                    style:
                        GoogleFonts.syne(fontSize: 20.0, color: Colors.black),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Esse é o seu primeiro mês de atividades, estamos felizes com seu início',
                    style:
                        GoogleFonts.syne(fontSize: 20.0, color: Colors.black),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: 250,
                child: CustomCarousel(imageList: _imageList),
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

class CustomCarousel extends StatefulWidget {
  final List<String> imageList;

  const CustomCarousel({required this.imageList, super.key});

  @override
  _CustomCarouselState createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.5);
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
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            width: MediaQuery.of(context).size.width * 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromARGB(255, 255, 255, 255),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 8,
                  blurRadius: 10,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
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
                      'Nível ${index + 1} Conquista',
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
        );
      },
    );
  }
}