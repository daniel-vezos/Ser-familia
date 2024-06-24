import 'package:app_leitura/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

  // Lista de sombras correspondentes a cada imagem
  final List<BoxShadow> _imageShadows = [
    const BoxShadow(
      color: Colors.black26,
      blurRadius: 4,
      offset: Offset(0, 3),
    ),
    const BoxShadow(
      color: Colors.black26,
      blurRadius: 4,
      offset: Offset(0, 3),
    ),
    const BoxShadow(
      color: Colors.black26,
      blurRadius: 4,
      offset: Offset(0, 3),
    ),
    const BoxShadow(
      color: Colors.black26,
      blurRadius: 4,
      offset: Offset(0, 3),
    ),
    const BoxShadow(
      color: Colors.black26,
      blurRadius: 4,
      offset: Offset(0, 3),
    ),
    const BoxShadow(
      color: Colors.black26,
      blurRadius: 4,
      offset: Offset(0, 3),
    ),
    const BoxShadow(
      color: Colors.black26,
      blurRadius: 4,
      offset: Offset(0, 3),
    ),
    const BoxShadow(
      color: Colors.black26,
      blurRadius: 4,
      offset: Offset(0, 3),
    ),
    const BoxShadow(
      color: Colors.black26,
      blurRadius: 4,
      offset: Offset(0, 3),
    ),
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
              padding: const EdgeInsets.all(5.0),
              child: Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: SizedBox(
                  height: 250,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      // ignore: unused_local_variable
                      final itemWidth = (constraints.maxWidth - 300) / 2;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _imageList.length,
                        itemBuilder: (context, index) {
                          final double itemWidth = (constraints.maxWidth + 90) / 2;
                
                          return Container(
                            margin: const EdgeInsets.only(bottom: 0),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                              child: SizedBox(
                                width: itemWidth,
                                child: CustomCard(imagePath: _imageList[index]),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
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

class MenuWidget extends StatelessWidget {
  const MenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 1, 35, 99),
      height: 70, // Ajusta a altura para acomodar o texto
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.emoji_events, color: Colors.white),
              SizedBox(height: 4), // Espaçamento entre ícone e texto
              Text(
                'conquistas',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
          SizedBox(width: 250), // Ajusta o espaço entre os ícones
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.person, color: Colors.white),
              SizedBox(height: 4), // Espaçamento entre ícone e texto
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

void main() {
  runApp(InitialHome());
}
