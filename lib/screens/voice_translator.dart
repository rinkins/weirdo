import 'package:flutter/material.dart';

class VoiceTranslationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Голосовой перевод')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.mic, size: 100, color: Colors.blue),
            SizedBox(height: 20),
            Text('Голосовой перевод (в разработке)'),
          ],
        ),
      ),
    );
  }
}