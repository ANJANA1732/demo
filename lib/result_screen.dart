import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final String text;

  const ResultScreen({super.key, required this.text, required String foundMedicineName});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Result'),
    ),
    body: Container(
      padding: const EdgeInsets.all(30.0),
      child: Text(text),
    ),
  );
}

