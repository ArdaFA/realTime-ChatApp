import 'package:chat_app/folders/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_or_register.dart';

// the purpose of the class is to check, if user is logged in or not

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // Depending on if:
          // user is logged in
              // user logged in. then return HomePage, because we do not need to register
          if(snapshot.hasData){
            return const HomePage();
          }
          // user is not logged in
          else {
            return const LoginOrRegister();
          }
        },
      ),

    );
  }
}
