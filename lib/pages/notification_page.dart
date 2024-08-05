import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/sub_menu_widget.dart';

class NotificationPage extends StatefulWidget {
  final String nameUser;
  final bool showMessage; // Adicione um parâmetro para controle inicial

  const NotificationPage({
    super.key,
    required this.nameUser,
    this.showMessage = false, // Valor padrão é false
  });

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool _showMessage = false;

  @override
  void initState() {
    super.initState();
    // Configura a visibilidade da mensagem
    if (widget.showMessage) {
      setState(() {
        _showMessage = true;
      });

      // Remove a mensagem após um período
      Future.delayed(const Duration(seconds: 5), () {
        if (mounted) {
          setState(() {
            _showMessage = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Configuração do ScreenUtil
    ScreenUtil.init(
      context,
      designSize: const Size(375, 820),
      minTextAdapt: true,
    );

    final TextStyle headerStyle = TextStyle(
      fontSize: 19.sp,
      fontWeight: FontWeight.normal,
      color: Colors.black,
      fontFamily: 'Roboto',
    );

    final TextStyle bodyStyle = TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.normal,
      color: Colors.black,
      fontFamily: 'Roboto',
    );

    final TextStyle titleStyle = TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.normal,
      color: Colors.black,
      fontFamily: 'Roboto',
    );

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Notificações',
          style: titleStyle,
        ),
      ),
      body: Container(
        color: Colors.grey[300],
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            Divider(
              height: 1.h,
              color: const Color(0x0ff7bac9),
            ),
            SizedBox(height: 10.h),
            if (_showMessage) // Condicional para mostrar a mensagem
              Wrap(
                children: [
                  Text(
                    'Uau! Mais uma semana está liberada. Continue brilhando!',
                    style: bodyStyle,
                  ),
                ],
              ),
            SizedBox(height: 10.h),
            Divider(
              height: 1.h,
              color: const Color(0x0ff7bac9),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SubMenuWidget(nameUser: widget.nameUser),
    );
  }
}
