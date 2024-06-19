import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InitialHome extends StatefulWidget {
  const InitialHome({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _InitialHomeState createState() => _InitialHomeState();
}

class _InitialHomeState extends State<InitialHome> {
  // Variáveis para os dados do aluno
  String nomeAluno = 'Aluno'; // Substitua pelo nome real do aluno
  String numeroMatricula = '123456'; // Substitua pelo número real da matrícula

  // Índice inicial do carrossel de imagens
  int _currentIndex = 0;

  // Lista de imagens para o carrossel
  final List<String> _imageList = [
    "assets/backgrounds/nivel1.png",
    "assets/backgrounds/nivel2.png",
    "assets/backgrounds/nivel3.png",
    "assets/backgrounds/nivel4.png",
    "assets/backgrounds/nivel5.png",
    "assets/backgrounds/nivel6.png",
    "assets/backgrounds/nivel7.png",
    "assets/backgrounds/nivel8.png",
    "assets/backgrounds/nivel9.png",
  ];

  void _previousImage() {
    setState(() {
      _currentIndex = (_currentIndex - 3) % _imageList.length;
      if (_currentIndex < 0) {
        _currentIndex += _imageList.length;
      }
    });
  }

  void _nextImage() {
    setState(() {
      _currentIndex = (_currentIndex + 3) % _imageList.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          // Removido o título da AppBar
          elevation: 0, // Remove a sombra da AppBar
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(
              vertical: 10), // Espaçamento vertical geral
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  12.0, 0, 12.0, 4.0), // Ajustado o espaçamento superior
              child: SizedBox(
                height: 100,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Olá, $nomeAluno\n',
                        style: GoogleFonts.nunitoSans(
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                      ),
                      const TextSpan(
                        text: '\n',
                      ),
                      TextSpan(
                        text: 'Você está no nível 1 - Início\n',
                        style: GoogleFonts.nunitoSans(
                          fontSize: 15.0,
                          color: Colors.black,
                        ),
                      ),
                      const TextSpan(
                        text: '\n',
                      ),
                      TextSpan(
                        text:
                            'Esse é o seu primeiro mês de atividades, estamos felizes com seu início',
                        style: GoogleFonts.nunitoSans(
                          fontSize: 13.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: SizedBox(
                height: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Container(
                        width: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: Offset(0, 3),
                            ),
                          ],
                          image: DecorationImage(
                            image: AssetImage(_imageList[_currentIndex]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    if (_imageList.length > 1)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Container(
                          width: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 4,
                                offset: Offset(0, 3),
                              ),
                            ],
                            image: DecorationImage(
                              image: AssetImage(
                                _imageList[
                                    (_currentIndex + 1) % _imageList.length],
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    if (_imageList.length > 2)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Container(
                          width: 110,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 4,
                                offset: Offset(0, 3),
                              ),
                            ],
                            image: DecorationImage(
                              image: AssetImage(
                                _imageList[
                                    (_currentIndex + 2) % _imageList.length],
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: _previousImage,
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: _nextImage,
                ),
              ],
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Center(
                child: Text(
                  'Próximas tarefas a serem liberadas',
                  style: GoogleFonts.nunitoSans(
                    fontSize: 20.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 60),
                ),
                icon: Padding(
                  padding: const EdgeInsets.only(
                    right: 10,
                  ),
                  child: Image.asset(
                    'assets/backgrounds/botao1.png',
                    width: 70,
                    height: 40,
                  ),
                ),
                label: const Text(
                  'Lista de Compras',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                onPressed: () {},
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 60),
                ),
                icon: Padding(
                  padding: const EdgeInsets.only(
                    right: 10,
                  ),
                  child: Image.asset(
                    'assets/backgrounds/botaook.png',
                    width: 70,
                    height: 55,
                  ),
                ),
                label: const Text(
                  'Propósito de Vida',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                onPressed: () {},
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 60),
                ),
                icon: Padding(
                  padding: const EdgeInsets.only(
                    right: 10,
                  ),
                  child: Image.asset(
                    'assets/backgrounds/botao3.png',
                    width: 70,
                    height: 40,
                  ),
                ),
                label: const Text(
                  'Lista de Compras',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                onPressed: () {},
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
        bottomNavigationBar: const MenuWidget(),
      ),
    );
  }
}

class MenuWidget extends StatelessWidget {
  const MenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      height: 50,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.home),
          SizedBox(width: 20),
          Icon(Icons.favorite),
          SizedBox(width: 20),
          Icon(Icons.settings),
        ],
      ),
    );
  }
}

void main() {
  runApp(const InitialHome());
}
