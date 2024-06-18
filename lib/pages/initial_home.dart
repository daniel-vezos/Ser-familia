import 'package:flutter/material.dart';

import '../widgets/sub_menu_widget.dart';

class InitialHome extends StatefulWidget {
  const InitialHome({super.key});

  @override
  _InitialHomeState createState() => _InitialHomeState();
}

class _InitialHomeState extends State<InitialHome> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Horizontal and Vertical Scroll App"),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 4.0),
              child: SizedBox(
                height: 100,
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Olá, Primeiro nome\n', // Seu texto aqui
                        style: TextStyle(
                          color:
                              Colors.black, // Personalize conforme necessário
                          fontSize: 14.0, // Personalize conforme necessário
                        ),
                      ),
                      TextSpan(
                        text:
                            '\n', // Adicione uma quebra de linha para espaçamento
                      ),
                      TextSpan(
                        text: 'Você está no nível 1 - Início\n',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17.0,
                        ),
                      ),
                      TextSpan(
                        text:
                            '\n', // Adicione uma quebra de linha para espaçamento
                      ),
                      TextSpan(
                        text:
                            'Esse é o seu primeiro mês de atividades, estamos felizes com seu início',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 4.0),
              child: SizedBox(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(100.0),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/backgrounds/grafico.png"),
                        ),
                      ),
                      child: Image.asset('assets/backgrounds/grafico.png'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        padding: const EdgeInsets.all(100.0),
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/backgrounds/lupa.png"),
                          ),
                        ),
                        child: Image.asset('assets/backgrounds/lupa.png'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        padding: const EdgeInsets.all(100.0),
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/backgrounds/lupa.png"),
                          ),
                        ),
                        child: Image.asset('assets/backgrounds/lupa.png'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        padding: const EdgeInsets.all(100.0),
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/backgrounds/lupa.png"),
                          ),
                        ),
                        child: Image.asset('assets/backgrounds/lupa.png'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        padding: const EdgeInsets.all(100.0),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          image: DecorationImage(
                            image: AssetImage("assets/backgrounds/lupa.png"),
                          ),
                        ),
                        child: Image.asset('assets/backgrounds/lupa.png'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 4.0),
              child: Text(
                'Próximas tarefas a serem liberadas',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: ElevatedButton.icon(
                label: const Text('Gratidão'),
                onPressed: () {},
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: ElevatedButton.icon(
                label: const Text('Propósito de Vida'),
                onPressed: () {},
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: ElevatedButton.icon(
                label: const Text('Lista de Compras'),
                onPressed: () {},
              ),
            )
          ],
        ),
        bottomNavigationBar:
            const MenuWidget(), // Aqui adicionamos o MenuWidget como rodapé
      ),
    );
  }
}
