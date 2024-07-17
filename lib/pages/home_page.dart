import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tts/flutter_tts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FlutterTts _flutterTts = FlutterTts();
  List<dynamic> _voices = [];
  dynamic _currentVoice;

  @override
  void initState() {
    super.initState();
    print("Initializing TTS...");
    initTTS();
  }

  Future<void> initTTS() async {
    try {
      _voices = await _flutterTts.getVoices;
      _voices = _voices
          .where((voice) => voice["locale"].toString().contains("pt-BR"))
          .toList();
      if (_voices.isNotEmpty) {
        setState(() {
          _currentVoice = _voices.first;
          setVoice(_currentVoice);
        });
      } else {
        print("Nenhuma voz em português brasileiro encontrada.");
      }
    } catch (e) {
      print("Erro ao inicializar TTS: $e");
    }
  }

  void setVoice(dynamic voice) {
    _flutterTts.setVoice({
      "name": voice["name"].toString(),
      "locale": voice["locale"].toString(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text-to-Speech'),
      ),
      body: _buildUI(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _flutterTts.speak(
              "Descubra uma nova maneira de acompanhar o progresso educacional dos seus filhos com o Ser Familia.");
        },
        child: const Icon(Icons.speaker_phone),
      ),
    );
  }

  Widget _buildUI() {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _speakerSelector(),
          RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 20,
                  color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                  text: "TTS_INPUT",
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _speakerSelector() {
    return DropdownButton<dynamic>(
      value: _currentVoice,
      items: _voices
          .map<DropdownMenuItem<dynamic>>(
            (voice) => DropdownMenuItem<dynamic>(
              value: voice,
              child: Text(
                voice["name"].toString(),
              ),
            ),
          )
          .toList(),
      onChanged: (value) {
        setState(() {
          _currentVoice = value;
          setVoice(_currentVoice);
        });
      },
    );
  }
}
