
import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/services/authentication/auth_gate.dart';
import 'package:chat_app/services/authentication/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() async {
  // It has to be checked, if the package/auth methods are initialized
  WidgetsFlutterBinding.ensureInitialized();
  // the we have to wait for Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); // uses firebase_core
  runApp(
    ChangeNotifierProvider(
        create: (context) => AuthService(),
    child: const MyApp(),)
  );
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: LoginOrRegister(),
      home: AuthGate(), // AuthGate is checking already, to where user should go.
      // Like register or login or if already registered then homepage
    );
  }
}
