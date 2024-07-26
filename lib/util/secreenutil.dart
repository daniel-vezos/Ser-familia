import 'package:app_leitura/pages/initial_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// Certifique-se de que o caminho está correto

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 820), // Ajuste o tamanho base do design
      builder: (context, child) {
        return const MaterialApp(
          home: InitialHome(nameUser: 'Usuário'), // Passe o nome do usuário
          debugShowCheckedModeBanner:
              false, // Opcional: remove o banner de debug
        );
      },
    );
  }
}
