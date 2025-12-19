import 'package:flutter/material.dart';
import 'screens/menu.dart';
import 'supabase/supabase_client.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Инициализируем Supabase
  await SupabaseService.init();
  
  // Проверяем подключение
  await SupabaseService.testConnection();
  
  runApp(TranslationApp());
}

class TranslationApp extends StatelessWidget {
  const TranslationApp({super.key});

  @id86240433 (@override)
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Переводчик',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MainMenuScreen(),
    );
  }
}