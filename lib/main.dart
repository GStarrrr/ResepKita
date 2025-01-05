import 'package:coba/favorite.dart';
import 'package:coba/history.dart';
import 'package:coba/homepage.dart';

import 'dashboard.dart';
import 'signup.dart';
import 'package:flutter/material.dart';
import 'wellcome.dart';
import 'signin.dart';

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
        '/login': (context) => const Signin(),
        '/signup': (context) => const Signup(),
        '/homepage': (context) => const HomePage(),
        '/favorite': (context) => const favorite(),
        '/history': (context) => const history(),
        '/Admin': (context) => Dashboard2(),
      },
    );
  }
}