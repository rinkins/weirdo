import 'package:flutter/material.dart';

// Точка входа - как main.js в Vue
void main() {
  runApp(TranslationApp());
}

// Корневой компонент приложения - как App.vue
class TranslationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Переводчик', // Аналог <title> в Vue
      theme: ThemeData(
        primarySwatch: Colors.blue, // Основной цвет
      ),
      home: TranslationScreen(), // Главный экран - как router-view
    );
  }
}

// Главный экран - как страница Vue с состоянием
class TranslationScreen extends StatefulWidget {
  @override
  _TranslationScreenState createState() => _TranslationScreenState();
}

// Класс состояния - как data() + methods в Vue Composition API
class _TranslationScreenState extends State<TranslationScreen> {
  // Reactive state - как ref() в Vue
  String _inputText = '';           // Текст для перевода
  String _translatedText = '';      // Результат перевода
  bool _isTranslating = false;      // Состояние загрузки
  
  // Словарь для перевода - как computed или внешний API
  final Map<String, String> _dictionary = {
    'hello': 'привет',
    'world': 'мир',
    'flutter': 'флаттер',
    'vue': 'вью',
    'developer': 'разработчик',
    'code': 'код',
    'app': 'приложение',
  };

  // Метод перевода - как method в Vue
  void _translateText() {
    setState(() {
      _isTranslating = true; // Запускаем "загрузку"
    });

    // Имитация асинхронного запроса к API - как await в Vue
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        // Преобразуем текст и ищем перевод
        final input = _inputText.toLowerCase().trim();
        _translatedText = _dictionary[input] ?? 'Перевод не найден';
        _isTranslating = false;
      });
    });
  }

  // Метод очистки - как method в Vue
  void _clearText() {
    setState(() {
      _inputText = '';
      _translatedText = '';
    });
  }

  // Build метод - как template в Vue
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar - как верхняя панель навигации
      appBar: AppBar(
        title: Text('Простой Переводчик'), // v-text эквивалент
        backgroundColor: Colors.blue.shade700,
      ),
      
      // Body - как основной контент в <template>
      body: Padding(
        padding: EdgeInsets.all(16.0), // Аналог CSS padding
        child: Column(
          children: [
            // Поле ввода - как v-model в Vue
            TextField(
              decoration: InputDecoration(
                labelText: 'Введите текст на английском',
                border: OutlineInputBorder(), // Стили как CSS
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: _clearText, // @click эквивалент
                ),
              ),
              onChanged: (value) {
                // v-model эквивалент - реактивное обновление
                setState(() {
                  _inputText = value;
                });
              },
            ),

            SizedBox(height: 20), // Отступ - как margin в CSS

            // Кнопка перевода - как @click в Vue
            ElevatedButton(
              onPressed: _inputText.isEmpty ? null : _translateText,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // CSS background-color
                foregroundColor: Colors.white, // CSS color
                minimumSize: Size(double.infinity, 50), // width: 100%
              ),
              child: _isTranslating 
                  ? Row( // Условный рендеринг - как v-if
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(color: Colors.white),
                        SizedBox(width: 10),
                        Text('Перевожу...'),
                      ],
                    )
                  : Text('Перевести'),
            ),

            SizedBox(height: 30),

            // Область результата
            Card( // Аналог <div class="card">
              elevation: 4, // CSS box-shadow
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Результат перевода:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold, // CSS font-weight
                        color: Colors.grey.shade700,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      _translatedText.isEmpty ? 'Здесь появится перевод' : _translatedText,
                      style: TextStyle(
                        fontSize: 18,
                        color: _translatedText.isEmpty ? Colors.grey : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // Подсказка со словами из словаря
            Expanded( // Занимает оставшееся пространство
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Доступные слова:',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  SizedBox(height: 10),
                  // Список слов - как v-for в Vue
                  Wrap(
                    spacing: 8, // CSS gap
                    children: _dictionary.keys.map((word) {
                      return Chip( // Тег-чипс
                        label: Text(word),
                        backgroundColor: Colors.blue.shade100,
                        onDeleted: () {
                          // Клик по слову - подставляет в поле ввода
                          setState(() {
                            _inputText = word;
                          });
                          _translateText();
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}