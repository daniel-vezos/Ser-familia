import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
                height: 250, // Aumentado para 250
                child: CustomCarousel(imageList: _imageList),
              ),
            ),
            const SizedBox(height: 30),
            _buildSectionTitle('Próximas tarefas a serem liberadas'),
            const SizedBox(height: 30),
            _buildElevatedButton(
                'Lista de Compras', 'assets/backgrounds/botao1.png'),
            const SizedBox(height: 20),
            _buildElevatedButton(
                'Propósito de Vida', 'assets/backgrounds/botaook.png'),
            const SizedBox(height: 20),
            _buildElevatedButton(
                'Lista de Compras', 'assets/backgrounds/botao3.png'),
            const SizedBox(height: 30),
          ],
        ),
        bottomNavigationBar: const MenuWidget(),
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

  Padding _buildElevatedButton(String text, String asset) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 60),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        icon: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Image.asset(asset, width: 70, height: 40),
        ),
        label: Text(
          text,
          style: GoogleFonts.syne(fontSize: 20.0, color: Colors.black),
        ),
        onPressed: () {},
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
          child: Container(
            margin: const EdgeInsets.symmetric(
                horizontal: 10), // Remova margens se não forem necessárias
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
              borderRadius: BorderRadius.circular(20),
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
                      'Nível ${index + 1} conquista',
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

class MenuWidget extends StatelessWidget {
  const MenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 1, 35, 99),
      height: 70,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.emoji_events, color: Colors.white),
              SizedBox(height: 4),
              Text(
                'conquistas',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
          SizedBox(width: 250),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.person, color: Colors.white),
              SizedBox(height: 4),
              Text(
                'perfil',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
