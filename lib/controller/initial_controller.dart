import 'package:flutter/material.dart';

class InitialController with ChangeNotifier {
  int _currentIndex = 0;
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

  int get currentIndex => _currentIndex;
  List<String> get imageList => _imageList;

  void previousImage() {
    _currentIndex = (_currentIndex - 3) % _imageList.length;
    if (_currentIndex < 0) {
      _currentIndex += _imageList.length;
    }
    notifyListeners();
  }

  void nextImage() {
    _currentIndex = (_currentIndex + 3) % _imageList.length;
    notifyListeners();
  }
}
