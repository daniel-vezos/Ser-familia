import 'package:app_leitura/util/my_card.dart';
import 'package:app_leitura/util/my_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'weeks_page.dart'; // Certifique-se de que o caminho está correto

class CardTeste extends StatefulWidget {
  final String nameUser; // Garantir que nameUser seja obrigatório
  final List<String> titles;

  const CardTeste({
    super.key,
    required this.nameUser,
    required this.titles,
  }); // Use required aqui

  @override
  _CardTesteState createState() => _CardTesteState();
}

class _CardTesteState extends State<CardTeste> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    const TextStyle buttonStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    );

    return Scaffold(
      backgroundColor: Colors.grey[300],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Olá ",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.nameUser,
                          style: const TextStyle(fontSize: 28),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.notifications),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Você está no nível 1 - inicio.",
                style: buttonStyle,
              ),
              const SizedBox(height: 15),
              const Text(
                "Esse é o seu primeiro mês de atividades, estamos felizes com seu início!",
                style: buttonStyle,
              ),
              const SizedBox(height: 30),
              SizedBox(
                height: 200,
                child: PageView(
                  scrollDirection: Axis.horizontal,
                  controller: _controller,
                  children: [
                    MyCard(
                      imagePath: 'assets/backgrounds/teste2.png',
                      title: 'Nível 1',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WeeksPage(
                              nameUser: widget.nameUser,
                              nivel: 'Nível 1 Conquista',
                              userName: widget.nameUser,
                              titles: null,
                            ),
                          ),
                        );
                      },
                    ),
                    MyCard(
                      imagePath: 'assets/backgrounds/teste2.png',
                      title: 'Nível 2',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WeeksPage(
                              nameUser: widget.nameUser,
                              nivel: 'Nível 2 Conquista',
                              userName: widget.nameUser,
                              titles: null,
                            ),
                          ),
                        );
                      },
                    ),
                    MyCard(
                      imagePath: 'assets/backgrounds/teste2.png',
                      title: 'Nível 3',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WeeksPage(
                              nameUser: widget.nameUser,
                              nivel: 'Nível 3 Conquista',
                              userName: widget.nameUser,
                              titles: null,
                            ),
                          ),
                        );
                      },
                    ),
                    MyCard(
                      imagePath: 'assets/backgrounds/teste2.png',
                      title: 'Nível 4',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WeeksPage(
                              nameUser: widget.nameUser,
                              nivel: 'Nível 4 Conquista',
                              userName: widget.nameUser,
                              titles: null,
                            ),
                          ),
                        );
                      },
                    ),
                    MyCard(
                      imagePath: 'assets/backgrounds/teste2.png',
                      title: 'Nível 5',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WeeksPage(
                              nameUser: widget.nameUser,
                              nivel: 'Nível 5 Conquista',
                              userName: widget.nameUser,
                              titles: null,
                            ),
                          ),
                        );
                      },
                    ),
                    MyCard(
                      imagePath: 'assets/backgrounds/teste2.png',
                      title: 'Nível 6',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WeeksPage(
                              nameUser: widget.nameUser,
                              nivel: 'Nível 6 Conquista',
                              userName: widget.nameUser,
                              titles: null,
                            ),
                          ),
                        );
                      },
                    ),
                    MyCard(
                      imagePath: 'assets/backgrounds/teste2.png',
                      title: 'Nível 7',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WeeksPage(
                              nameUser: widget.nameUser,
                              nivel: 'Nível 7 Conquista',
                              userName: widget.nameUser,
                              titles: null,
                            ),
                          ),
                        );
                      },
                    ),
                    MyCard(
                      imagePath: 'assets/backgrounds/teste2.png',
                      title: 'Nível 8',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WeeksPage(
                              nameUser: widget.nameUser,
                              nivel: 'Nível 8 Conquista',
                              userName: widget.nameUser,
                              titles: null,
                            ),
                          ),
                        );
                      },
                    ),
                    MyCard(
                      imagePath: 'assets/backgrounds/teste2.png',
                      title: 'Nível 9',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WeeksPage(
                              nameUser: widget.nameUser,
                              nivel: 'Nível 9 Conquista',
                              userName: widget.nameUser,
                              titles: null,
                            ),
                          ),
                        );
                      },
                    ),
                    // Adicione mais MyCard com imagens e títulos diferentes conforme necessário
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: SmoothPageIndicator(
                  controller: _controller,
                  count: 9,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Color.fromARGB(255, 13, 61, 144),
                    dotHeight: 8,
                    dotWidth: 8,
                    spacing: 10,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              const Center(
                child: Text(
                  "Próximas tarefas a serem liberadas",
                  style: buttonStyle,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  children: const [
                    MyListTile(
                      inconImagePath: "assets/backgrounds/botao1.png",
                      tileTile: "Gratidão",
                      onTap: null,
                      tilesubTile: '', // Remove a função de clique
                    ),
                    SizedBox(height: 20),
                    MyListTile(
                      inconImagePath: "assets/backgrounds/botao1.png",
                      tileTile: "Propósito de Vida",
                      tilesubTile: "",
                      onTap: null, // Remove a função de clique
                    ),
                    SizedBox(height: 20),
                    MyListTile(
                      inconImagePath: "assets/backgrounds/botao1.png",
                      tileTile: "Lista de Compras",
                      tilesubTile: "",
                      onTap: null, // Remove a função de clique
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
