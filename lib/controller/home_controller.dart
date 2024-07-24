import 'dart:convert';
import 'package:app_leitura/data/weeks_data.dart';

class HomeController {
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

  List<String> getImageList() => _imageList;

  List<String> extractTitles() {
    Map<String, dynamic> jsonData = json.decode(weeks);
    List<String> titles = [];

    jsonData.forEach((nivel, semanas) {
      titles.add(nivel);
    });

    return titles;
  }
}
