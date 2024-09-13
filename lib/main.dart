import 'package:app_leitura/widgets/notification_key.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:app_leitura/api/firebase_api_notification.dart';
import 'package:app_leitura/pages/initial_page.dart';
import 'package:app_leitura/pages/notification_page.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicialização do Firebase
  await Firebase.initializeApp();
  print('Firebase inicializado com sucesso.');

  // Inicialize FirebaseApi e chame initNotifications
  final firebaseApi = FirebaseApi();
  await firebaseApi.initNotifications();
  print('Notificações do Firebase inicializadas.');

  // Inicialização do Awesome Notifications
  await AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelGroupKey: "basic_channel_group",
        channelKey: "basic_channel",
        channelName: "Basic Notification",
        channelDescription: "Basic notifications channel",
      )
    ],
    channelGroups: [
      NotificationChannelGroup(
        channelGroupKey: "basic_channel_group",
        channelGroupName: "Basic Group",
      )
    ],
  );
  print('Awesome Notifications inicializado.');

  // Verificação de permissão para enviar notificações
  bool isAllowedToSendNotification =
      await AwesomeNotifications().isNotificationAllowed();
  if (!isAllowedToSendNotification) {
    await AwesomeNotifications().requestPermissionToSendNotifications();
    print('Permissão para enviar notificações solicitada.');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ser Familia',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorKey:
          navigatorKey, // Chave do navegador para manipulação da navegação
      home: const InitialPage(),
      routes: {
        NotificationPage.route: (context) => const NotificationPage(),
        // Outras rotas, se necessário
      },
      initialRoute: '/',
    );
  }
}
