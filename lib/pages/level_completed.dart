import 'package:app_leitura/widgets/sub_menu_home_widget.dart';
import 'package:flutter/material.dart';

class LevelCompletedPage extends StatelessWidget {
  const LevelCompletedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> imagePaths = [
      'assets/backgrounds/teste.png',
      'assets/backgrounds/teste2.png',
      'assets/backgrounds/teste3.png',
      'assets/backgrounds/teste4.png',
      'assets/backgrounds/teste5.png',
      'assets/backgrounds/teste6.png',
      'assets/backgrounds/teste7.png',
      'assets/backgrounds/teste8.png',
      'assets/backgrounds/teste99.png',
    ];

    // Nível máximo desbloqueado (você pode alterar essa variável conforme os níveis são concluídos)
    const int maxUnlockedLevel =
        1; // Apenas nível 1 está desbloqueado inicialmente

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
          ),
          itemCount: imagePaths.length,
          itemBuilder: (BuildContext context, int index) {
            bool isUnlocked = index < maxUnlockedLevel;

            return GestureDetector(
              onTap: isUnlocked
                  ? () {
                      // Ação ao clicar no card desbloqueado
                    }
                  : null,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        imagePaths[index],
                        fit: BoxFit.cover,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: double.infinity,
                          color: const Color.fromARGB(137, 222, 209, 209)
                              .withOpacity(0.6),
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Nível ${index + 1}',
                            style: const TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 5, 5, 5),
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      if (!isUnlocked)
                        Container(
                          color: Colors.black.withOpacity(0.5),
                          child: const Center(
                            child: Icon(
                              Icons.lock,
                              color: Colors.white,
                              size: 50,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: const MenuHomeWidget(),
    );
  }
}
