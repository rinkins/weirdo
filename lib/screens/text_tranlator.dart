import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../supabase/supabase_client.dart';

class TranslationScreen extends StatefulWidget {
  const TranslationScreen({super.key});

(@override)
  _TranslationScreenState createState() => _TranslationScreenState();
}

class _TranslationScreenState extends State<TranslationScreen> {
  String _inputText = '';
  String _translatedText = '';
  bool _isLoading = false;
  List<Map<String, dynamic>> _translations = [];

(@override)
  void initState() {
    super.initState();
    _loadTranslations();
  }

  // Просто загрузить все переводы из базы
  Future<void> _loadTranslations() async {
    setState(() => _isLoading = true);
    
    try {
      final response = await SupabaseService.client
          .from('translations')
          .select('*')
          .order('created_at', ascending: false);
      
      setState(() {
        _translations = List<Map<String, dynamic>>.from(response);
      });
      
      print('✅ Загружено ${_translations.length} переводов');
    } catch (e) {
      print('❌ Ошибка загрузки: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // Просто сохранить перевод в базу
  Future<void> _saveTranslation() async {
    if (_inputText.isEmpty) return;
    
    setState(() => _isLoading = true);
    
    try {
      // Простой перевод
      final translation = _inputText == 'hello' ? 'привет' : 'мир';
      
      // Сохраняем в Supabase
      await SupabaseService.client
          .from('translations')
          .insert({
            'english': _inputText,
            'russian': translation,
            'created_at': DateTime.now().toIso8601String(),
          });
      
      setState(() {
        _translatedText = translation;
      });
      
      // Обновляем список
      await _loadTranslations();
      
      print('✅ Перевод сохранен в Supabase!');
    } catch (e) {
      print('❌ Ошибка сохранения: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  (@override)
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Supabase Переводчик'),
        backgroundColor: Colors.blue,
      ),
      
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Простое поле ввода
            TextField(
              decoration: InputDecoration(
                labelText: 'Введите слово (например: hello)',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => _inputText = value,
            ),
            
            SizedBox(height: 20),
            
            // Кнопка сохранить
            ElevatedButton(
              onPressed: _isLoading ? null : _saveTranslation,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: Size(double.infinity, 50),
              ),
              child: _isLoading 
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text('Сохранить в Supabase'),
            ),
            
            SizedBox(height: 20),
            
            // Просто показать результат
            if (_translatedText.isNotEmpty)
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Перевод: $_translatedText',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            
            SizedBox(height: 20),
            
            // Простой список из базы
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Переводы из базы:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  
                  SizedBox(height: 10),


xpanded(
                    child: _isLoading
                        ? Center(child: CircularProgressIndicator())
                        : _translations.isEmpty
                            ? Center(child: Text('Нет переводов в базе'))
                            : ListView.builder(
                                itemCount: _translations.length,
                                itemBuilder: (context, index) {
                                  final item = _translations[index];
                                  return ListTile(
                                    leading: CircleAvatar(child: Text('${index + 1}')),
                                    title: Text('${item['english']} → ${item['russian']}'),
                                    subtitle: Text('ID: ${item['id']}'),
                                  );
                                },
                              ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      
      // Просто кнопка обновить
      floatingActionButton: FloatingActionButton(
        onPressed: _loadTranslations,
        child: Icon(Icons.refresh),
        backgroundColor: Colors.blue,
      ),
    );
  }
}