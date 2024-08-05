import 'package:firebase_auth/firebase_auth.dart';
import 'package:app_leitura/pages/initial_home.dart';
import 'package:app_leitura/pages/initial_page.dart';
import 'package:flutter/material.dart';

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.hasData) {
            return const InitialHome(
              nameUser: '',
            );
          } else {
            return const InitialPage();
          }
        }
      },
    );
  }
}
