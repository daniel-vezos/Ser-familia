import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:async';

class PageTasks extends StatefulWidget {
  final String title;
  final String challenge;

  const PageTasks({super.key, required this.title, required this.challenge, required String nameUser});

  @override
  _PageTasksState createState() => _PageTasksState();
}

class _PageTasksState extends State<PageTasks> {
  bool _isPlaying = false;
  double _currentSliderValue = 0.0;
  final double _maxSliderValue = 1.0; // Slider vai de 0.0 a 1.0
  late FlutterTts _flutterTts;
  Timer? _timer;
  // ignore: unused_field
  double _lastPausedPosition = 0.0;
  final double _speechRate = 0.5; // Defina a taxa de fala desejada
  Duration _totalDuration = Duration.zero;
  int _textLength = 0;

  @override
  void initState() {
    super.initState();
    _flutterTts = FlutterTts();
    _initTts();
  }

  void _initTts() async {
    await _flutterTts.setLanguage('pt-BR');
    await _flutterTts.setSpeechRate(_speechRate);
    await _flutterTts.awaitSpeakCompletion(true); // Esperar a conclusão da fala
    _flutterTts.setCompletionHandler(() {
      setState(() {
        _isPlaying = false;
        _currentSliderValue = _maxSliderValue;
      });
      _timer?.cancel();
    });

    // Estime o tempo total de fala
    _textLength = widget.challenge.length;
    int estimatedDurationMillis = (_textLength / _speechRate * 1000).toInt();
    _totalDuration = Duration(milliseconds: estimatedDurationMillis);
  }

  void _speak(String text) async {
    await _flutterTts.stop();
    _lastPausedPosition = 0; // Resetar posição pausada
    await _flutterTts.speak(text);
    setState(() {
      _isPlaying = true;
      _currentSliderValue = 0.0; // Resetar slider para o início
    });
    _startTimer();
  }

  void _pause() {
    _flutterTts.stop();
    _timer?.cancel();
    setState(() {
      _isPlaying = false;
      _lastPausedPosition = _currentSliderValue * _textLength;
    });
  }

  void _stop() {
    _flutterTts.stop();
    _timer?.cancel();
    setState(() {
      _isPlaying = false;
      _currentSliderValue = 0.0; // Resetar slider para o início
    });
  }

  void _startTimer() {
    const updateInterval = Duration(milliseconds: 100);

    _timer = Timer.periodic(updateInterval, (timer) {
      if (_isPlaying) {
        setState(() {
          _currentSliderValue +=
              updateInterval.inMilliseconds / _totalDuration.inMilliseconds;
        });

        if (_currentSliderValue >= _maxSliderValue) {
          timer.cancel();
          setState(() {
            _isPlaying = false;
            _currentSliderValue = _maxSliderValue;
          });
        }
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _flutterTts.stop();
    super.dispose();
  }

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
        actions: const [], // Adicione os botões necessários
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tarefa',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              widget.title,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 20),
            Text(
              widget.challenge,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: _isPlaying
                          ? const Icon(Icons.pause)
                          : const Icon(Icons.play_arrow),
                      onPressed: () {
                        if (_isPlaying) {
                          _pause();
                        } else {
                          _speak(widget.challenge);
                        }
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
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _stop,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.orange, // Cor de fundo laranja
                        ),
                        child: const Text(
                          'Atividade Realizada',
                          style: TextStyle(
                              color: Colors.white), // Cor do texto branco
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Ação do botão Parabéns
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue, // Cor de fundo azul
                        ),
                        child: const Text(
                          'Parabéns',
                          style: TextStyle(
                              color: Colors.white), // Cor do texto branco
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
