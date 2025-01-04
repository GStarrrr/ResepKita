import 'package:flutter/material.dart';

class history extends StatelessWidget {
  const history({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'history',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }
}

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}