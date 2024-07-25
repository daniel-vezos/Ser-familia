import 'package:app_leitura/widgets/button_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import '../widgets/sub_menu_widget.dart';

class NotificationPage extends StatelessWidget {
  final String nameUser;

  const NotificationPage({
    super.key,
    required this.nameUser,
  });

  @override
  Widget build(BuildContext context) {
    // Configuração do ScreenUtil
    ScreenUtil.init(
      context,
      designSize:
          const Size(375, 820), // Tamanho base para as resoluções móveis
      minTextAdapt: true,
    );

    final TextStyle headerStyle = TextStyle(
      fontSize: 19.sp,
      fontWeight: FontWeight.normal, // Ajuste o peso da fonte para normal
      color: Colors.black,
      fontFamily: 'Roboto', // Define a fonte Roboto
    );

    final TextStyle bodyStyle = TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.normal, // Ajuste o peso da fonte para normal
      color: Colors.black,
      fontFamily: 'Roboto', // Define a fonte Roboto
    );

    final TextStyle titleStyle = TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.normal, // Ajuste o peso da fonte para bold
      color: Colors.black,
      fontFamily: 'Roboto', // Define a fonte Roboto
    );

    return Scaffold(
      backgroundColor:
          Colors.grey[300], // Define a cor de fundo para o Scaffold
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
        actions: [ButtonNotification(nameUser: nameUser)],
      ),
      body: Container(
        color: Colors.grey[300], // Define a cor de fundo para o Container
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            Divider(
              height: 1.h,
              color: const Color(0x0ff7bac9), // Corrigido o código de cor
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Você recebeu uma nova tarefa',
                  style: bodyStyle,
                ),
                Text(
                  '01/01',
                  style: bodyStyle,
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Divider(
              height: 1.h,
              color: const Color(0x0ff7bac9), // Corrigido o código de cor
            ),
          ],
        ),
      ),
      bottomNavigationBar: SubMenuWidget(nameUser: nameUser),
    );
  }
}
