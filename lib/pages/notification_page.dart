import 'package:app_leitura/widgets/sub_menu_widget.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  final String nameUser;
  final bool showMessage;

  const NotificationPage({
    super.key,
    required this.nameUser,
    required this.showMessage,
  });

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  String? _message;

  @override
  void initState() {
    super.initState();
    _updateMessage();
  }

  @override
  void didUpdateWidget(covariant NotificationPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Atualiza a mensagem quando os parâmetros mudam
    if (widget.showMessage != oldWidget.showMessage) {
      _updateMessage();
    }
  }

  void _updateMessage() {
    if (widget.showMessage) {
      _message =
          'A semana seguinte foi liberada! Continue avançando e alcançando seus objetivos!';
    } else {
      _message = null;
    }
    setState(() {});
  }

  @override
  void dispose() {
    // Limpa a mensagem quando a página é destruída
    _message = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: const Text('Notificação'),
      ),
      backgroundColor: Colors.grey[300],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Espaçamento entre o título e a mensagem
          const SizedBox(height: 20), // Ajuste a altura conforme necessário

          _message != null
              ? Text(
                  _message!,
                  style: const TextStyle(fontSize: 15),
                  textAlign: TextAlign.center,
                )
              : Text(
                  'Espere as proximas liberações, ${widget.nameUser}!',
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
        ],
      ),
      bottomNavigationBar: SubMenuWidget(nameUser: widget.nameUser)
    );
  }
}
