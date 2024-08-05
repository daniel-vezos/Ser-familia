import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyListTile extends StatelessWidget {
  final String inconImagePath;
  final String tileTile;
  final VoidCallback? onTap;

  const MyListTile({
    super.key,
    required this.inconImagePath,
    required this.tileTile,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(inconImagePath),
      title: Center(
        child: Text(
          tileTile,
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
