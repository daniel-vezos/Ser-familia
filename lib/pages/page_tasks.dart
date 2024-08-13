import 'package:app_leitura/pages/page_congrats.dart';
import 'package:app_leitura/widgets/button_notification.dart';
import 'package:app_leitura/widgets/sub_menu_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import necessário para Firestore
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:app_leitura/auth/auth_service.dart';
import 'dart:async';

class PageTasks extends StatefulWidget {
  final String nameUser;
  final String title;
  final String challenge;
  final List<Map<String, dynamic>> themes;

  const PageTasks({
    super.key,
    required this.title,
    required this.challenge,
    required this.nameUser,
    required this.themes,
  });

  @override
  _PageTasksState createState() => _PageTasksState();
}

class _PageTasksState extends State<PageTasks> {
  bool _isPlaying = false;
  double _currentSliderValue = 0.0;
  final double _maxSliderValue = 1.0; // Slider vai de 0.0 a 1.0
  late FlutterTts _flutterTts;
  Timer? _timer;
  double _lastPausedPosition = 0.0;
  final double _speechRate = 0.5; // Defina a taxa de fala desejada
  int _textLength = 0;
  late Duration _totalDuration;
  bool _isActivityCompleted = false;

  @override
  void initState() {
    super.initState();
    _flutterTts = FlutterTts();
    _initTts();
    _checkActivityStatus(); // Verifica o status da atividade
  }

  void _initTts() async {
    await _flutterTts.setLanguage('pt-BR');
    await _flutterTts.setSpeechRate(_speechRate);
    await _flutterTts.awaitSpeakCompletion(true); // Esperar a conclusão da fala
    _flutterTts.setCompletionHandler(() {
      if (mounted) {
        setState(() {
          _isPlaying = false;
          _currentSliderValue = _maxSliderValue;
        });
      }
      _timer?.cancel();
    });

    _flutterTts.setCancelHandler(() {
      if (mounted) {
        setState(() {
          _isPlaying = false;
        });
      }
      _timer?.cancel();
    });

    // Estime o tempo total de fala
    _textLength = widget.challenge.length;
    _totalDuration =
        Duration(seconds: (_textLength / (_speechRate * 200)).round());
  }

  void _checkActivityStatus() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }

    final firestore = FirebaseFirestore.instance;
    final userDoc = firestore.collection('users').doc(user.uid);
    final activityDoc = userDoc.collection('activities').doc(widget.title);

    try {
      final doc = await activityDoc.get();
      if (doc.exists) {
        // Ensure proper casting of the data
        final data = doc.data(); // Cast to Map<String, dynamic> if data exists
        setState(() {
          _isActivityCompleted = data?['completed'] ?? false; // Use safe access with `?`
        });
      } else {
        setState(() {
          _isActivityCompleted = false;
        });
      }
    } catch (e) {
      print('Erro ao verificar o status da atividade: ${e.toString()}');
    }
  }

  void _speak(String text) async {
    print('Iniciando a fala com o texto: $text');
    setState(() {
      _isPlaying = true;
      _currentSliderValue = 0.0; // Reiniciar o slider no início
      _lastPausedPosition = 0.0; // Reiniciar a posição pausada no início
    });
    await _flutterTts.stop();
    await _flutterTts.speak(text);
    _startTimer();
  }

  void _pause() {
    _flutterTts.pause();
    _timer?.cancel();
    if (mounted) {
      setState(() {
        _isPlaying = false;
        _lastPausedPosition = _currentSliderValue * _textLength;
      });
    }
  }

  void _stop() {
    _flutterTts.stop();
    _timer?.cancel();
    if (mounted) {
      setState(() {
        _isPlaying = false;
        _currentSliderValue = 0.0; // Resetar slider para o início
        _lastPausedPosition = 0.0; // Resetar a posição pausada para o início
      });
    }
  }

  void _startTimer() {
    const updateInterval = Duration(milliseconds: 100);

    DateTime startTime = DateTime.now();
    _timer = Timer.periodic(updateInterval, (timer) {
      if (_isPlaying) {
        DateTime now = DateTime.now();
        double elapsedSeconds =
            now.difference(startTime).inMilliseconds / 1000.0;
        double estimatedProgress =
            (elapsedSeconds / _totalDuration.inSeconds).clamp(0.0, 1.0);
        if (mounted) {
          setState(() {
            _currentSliderValue = estimatedProgress;
          });
        }

        if (_currentSliderValue >= 1.0) {
          timer.cancel();
          if (mounted) {
            setState(() {
              _isPlaying = false;
              _currentSliderValue = 1.0;
            });
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _flutterTts.stop();
    super.dispose();
  }

  final AuthService _authService = AuthService();

  void _completeActivity() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuário não autenticado.')),
      );
      return;
    }

    final firestore = FirebaseFirestore.instance;
    final userDoc = firestore.collection('users').doc(user.uid);
    final activityDoc = userDoc.collection('activities').doc(widget.title);

    try {
      await firestore.runTransaction((transaction) async {
        final snapshot = await transaction.get(activityDoc);
        if (snapshot.exists) {
          throw Exception('A atividade já foi realizada.');
        }
        transaction.set(activityDoc, {'completed': true});
        await _authService.updatePoints(10); // Adiciona 10 pontos
      });

      // Atualiza o estado da atividade após completar
      setState(() {
        _isActivityCompleted = true;
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CongratsPage(
            nameUser: widget.nameUser,
            weekTitle: widget.title,
            themes: widget.themes,
            title: widget.title,
          ),
        ),
      );
    } catch (e) {
      print('Erro ao completar a atividade: ${e.toString()}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Erro ao completar a atividade: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const Center(child: Text('Usuário não autenticado.'));
    }

    return Scaffold(
      backgroundColor: Colors.grey[300], // Cor de fundo do Scaffold
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          ButtonNotification(nameUser: widget.nameUser),
          const SizedBox(width: 16),
        ],
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('activities')
            .doc(widget.title)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.exists) {
            return const Center(child: Text('A atividade já foi realizada.'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              color: Colors.grey[300], // Cor de fundo do corpo da página
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
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.challenge,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!_isActivityCompleted)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.grey[400],
                      child: IconButton(
                        icon: Icon(
                          _isPlaying ? Icons.pause : Icons.play_arrow,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          if (_isPlaying) {
                            _pause();
                          } else {
                            _speak(widget.challenge);
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 20),
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.grey[400],
                      child: IconButton(
                        icon: const Icon(Icons.stop, color: Colors.white),
                        onPressed: () {
                          _stop();
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
                        onPressed: _isActivityCompleted
                            ? null
                            : () {
                                _stop();
                                _completeActivity();
                              },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: _isActivityCompleted
                                ? Colors.grey
                                : const Color(0xffF5792F),
                            padding:
                                const EdgeInsets.symmetric(vertical: 15.0)),
                        child: const Text(
                          'Marcar como Realizada',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SubMenuWidget(nameUser: widget.nameUser.split(' ')[0]), // Adicionado o SubMenuWidget
        ],
      ),
    );
  }
}
