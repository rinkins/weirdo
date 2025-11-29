import 'package:flutter/material.dart';
import 'screens/menu.dart';

void main() {
  runApp(TranslationApp());
}

class TranslationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Многофункциональный Переводчик',
      home: MainMenuScreen(),
    );
  }
}