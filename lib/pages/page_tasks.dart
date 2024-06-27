import 'package:app_leitura/widgets/button_notification.dart';
import 'package:app_leitura/widgets/sub_menu_widget.dart';
import 'package:flutter/material.dart';
import 'page_congrats.dart'; // Importe o arquivo PAGE_CONGRATS.dart aqui

class PageTasks extends StatefulWidget {
  const PageTasks({super.key});

  @override
  _PageTasksState createState() => _PageTasksState();
}

class _PageTasksState extends State<PageTasks> {
  bool _isPlaying = false;
  double _currentSliderValue = 0.0;
  final double _maxSliderValue = 100.0; // Valor máximo do Slider

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(''), // Título da página
        actions: const [ButtonNotification()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tarefa',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Você conhece sua família?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 20),
            const Text(
              'Texto de exemplo: Este é um texto de exemplo que pode ser substituído pelo conteúdo real da sua tarefa. ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 20),
            const Spacer(),
            Row(
              children: [
                IconButton(
                  icon: _isPlaying
                      ? const Icon(Icons.pause)
                      : const Icon(Icons.play_arrow),
                  onPressed: () {
                    setState(() {
                      _isPlaying = !_isPlaying;
                    });
                  },
                ),
                Expanded(
                  child: Slider(
                    value: _currentSliderValue,
                    min: 0.0,
                    max: _maxSliderValue,
                    onChanged: (value) {
                      setState(() {
                        _currentSliderValue = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '00:00', // Tempo atual
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  '02:30', // Duração total (fixa para exemplo)
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 10), // Espaço entre os botões
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Ação ao clicar no botão abaixo de "Atividade realizada"
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CongratsPage()), // Substitua CongratsPage pelo nome correto da sua página
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange, // Cor de fundo laranja
                    ),
                    child: const Text(
                      'Atividade Realizada',
                      style: TextStyle(color: Colors.white), // Cor do texto branco
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const SubMenuDefaultWidget(),
    );
  }
}
