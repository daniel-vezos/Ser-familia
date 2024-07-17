import 'package:flutter/material.dart';

class CoinWidget extends StatefulWidget {
  const CoinWidget({super.key});

  @override
  State<CoinWidget> createState() => _CoinWidgetState();
}

class _CoinWidgetState extends State<CoinWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text('100'),
    );
  }
}