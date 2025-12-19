 import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  // Инициализация подключения
  static Future<void> init() async {
    await Supabase.initialize(
      url:'https://hnyojjuoemfamydubhiz.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhueW9qanVvZW1mYW15ZHViaGl6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjQ2Njk4NTMsImV4cCI6MjA4MDI0NTg1M30.-ZqDkRw74ZoXCLq2y-k9-dENSMW8hNCaLWSPcwI3eos',
    );
  }

  // Получить клиент
  static SupabaseClient get client => Supabase.instance.client;

  // Проверить подключение
  static Future<bool> testConnection() async {
    try {
      // Просто получаем одну запись из таблицы translations
      final response = await client
          .from('translations')
          .select()
          .limit(1);
      
      print('Подключение к Supabase успешно! Найдено записей: ${response.length}');
      return true;
    } catch (e) {
      print('Ошибка подключения к Supabase: $e');
      return false;
    }
  }
}