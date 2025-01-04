import 'package:flutter/material.dart';

class favorite extends StatelessWidget {
  const favorite({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'favorites',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }
}

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}