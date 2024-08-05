import 'package:flutter/material.dart';

class NotificationDefault {
  static final NotificationDefault _instance = NotificationDefault._internal();
  bool _showMessage = false;

  factory NotificationDefault() {
    return _instance;
  }

  NotificationDefault._internal();

  bool get showMessage => _showMessage;
  set showMessage(bool value) {
    _showMessage = value;
  }
}
