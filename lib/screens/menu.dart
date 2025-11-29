import 'package:flutter/material.dart';
import 'text_tranlator.dart';
import 'voice_translator.dart';

class MainMenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Режимы перевода')),
      body: ListView(
        children: [
          ListTile(
            title: Text('📝 Текстовый перевод'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => TranslationScreen()
              ));
            },
          ),
          ListTile(
            title: Text('🎤 Голосовой перевод'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => VoiceTranslationScreen()
              ));
            },
          ),
        ],
      ),
    );
  }
}