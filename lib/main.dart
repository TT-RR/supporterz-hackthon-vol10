import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:twitter/view/account/account_page.dart';
import 'package:twitter/view/start_up/login_page.dart';
import 'package:twitter/view/time_line/time_line_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: loginValidate(),
    );
  }
}

