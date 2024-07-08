import 'dart:convert';
import 'package:app_leitura/widgets/button_notification.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_leitura/pages/weeks_page.dart'; // Importe a página WeeksPage
import 'package:app_leitura/data/weeks_data_new.dart'; // Importe o JSON
import '../widgets/button_default.dart';
import '../widgets/sub_menu_home_widget.dart';

void main() {
  String nomeDoUsuario = "Nome do Usuário";
  runApp(InitialHome(name: nomeDoUsuario));
}

class InitialHome extends StatelessWidget {
  final String name;

  InitialHome({super.key, required this.name});

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

  List<String> _extractTitles(String jsonString) {
    Map<String, dynamic> jsonData = json.decode(jsonString);
    List<String> titles = [];

    jsonData.forEach((nivel, semanas) {
      titles.add(nivel);
    });

    return titles;
  }

  @override
  Widget build(BuildContext context) {
    List<String> titles = _extractTitles(weeks);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('', style: TextStyle(color: Colors.black)),
          actions: const [ButtonNotification()],
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 10),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12.0, 0, 12.0, 4.0),
              child: Row(
                children: [
                  Text(
                    'Olá, $name', // Exibe o nome dinâmico do usuário aqui
                    style: GoogleFonts.syne(fontSize: 20.0, color: Colors.black),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12.0, 0, 12.0, 4.0),
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
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: 250, // Aumentado para 250
                child: CustomCarousel(imageList: _imageList, titles: titles),
              ),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Próximas tarefas a serem liberadas'),
            const SizedBox(height: 30),
            CustomButtonDefault(
              title: 'Lista de Compras',
              assetsPath: 'assets/backgrounds/botao1.png',
              onPressed: () {
                // Implementar ação
              },
              borderRadius: BorderRadius.circular(10),
            ),
            const SizedBox(height: 20),
            CustomButtonDefault(
              title: 'Propósito de Vida',
              assetsPath: 'assets/backgrounds/botaook.png',
              onPressed: () {
                // Implementar ação
              },
              borderRadius: BorderRadius.circular(10),
            ),
            const SizedBox(height: 20),
            CustomButtonDefault(
              title: 'Lista de Compras',
              assetsPath: 'assets/backgrounds/botao3.png',
              onPressed: () {
                // Implementar ação
              },
              borderRadius: BorderRadius.circular(10),
            ),
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
  final List<String> titles;

  const CustomCarousel({required this.imageList, required this.titles, super.key});

  @override
  _CustomCarouselState createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.5,
      initialPage: 200, // Iniciar na primeira página
    );

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
                    nivel: widget.titles[index], // Passa o título do nível
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
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
                        widget.titles.length > index ? widget.titles[index] : 'Título não encontrado',
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
