import 'package:flutter/material.dart';
import 'wellcome.dart';
import 'login.dart';
import 'homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Your App',
      initialRoute: '/', // You can set the initial route to `/`
      routes: {
        '/': (context) => const Welcome(),
        '/login': (context) => const Login(),
        '/homepage': (context) => const homepage(),
      },
    );
  }
}