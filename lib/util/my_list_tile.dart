import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyListTile extends StatelessWidget {
  final String iconImagePath; // Corrigido
  final String tileTitle; // Corrigido
  final VoidCallback? onTap;

  const MyListTile({
    super.key,
    required this.iconImagePath, // Corrigido
    required this.tileTitle, // Corrigido
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(iconImagePath), // Corrigido
      title: Center(
        child: Text(
          tileTitle, // Corrigido
          style: TextStyle(
            fontSize: 20.sp, // Utiliza o ScreenUtil para o tamanho da fonte do título
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
