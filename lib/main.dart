
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/meditations_screen.dart';
import 'screens/library_screen.dart';
import 'screens/profile_screen.dart';

// Точка входа в приложение
void main() {
  runApp(const MeditationHarmonyApp());
}

/// Корневой виджет приложения "Meditation Harmony".
///
/// Он настраивает тему, маршрутизацию и основной макет приложения.
class MeditationHarmonyApp extends StatelessWidget {
  const MeditationHarmonyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meditation Harmony',
      // Определяем основную тему приложения в соответствии с ТЗ (минимализм, спокойные цвета)
      theme: ThemeData(
        primarySwatch: Colors.teal, // Спокойный, зеленоватый цвет
        scaffoldBackgroundColor: Colors.white,
        // Настройка для нижней навигационной панели
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.teal, // Цвет активной иконки
          unselectedItemColor: Colors.grey, // Цвет неактивных иконок
        ),
        // Задаем основной шрифт, если потребуется
        // fontFamily: 'Roboto',
      ),
      home: const MainScreen(),
      debugShowCheckedModeBanner: false, // Убираем баннер "Debug"
    );
  }
}

/// Главный экран приложения, содержащий нижнюю навигационную панель.
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Индекс текущего выбранного экрана
  int _selectedIndex = 0;

  // Список виджетов (экранов) для навигации
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    MeditationsScreen(),
    LibraryScreen(),
    ProfileScreen(),
  ];

  // Метод для обработки нажатия на элемент навигационной панели
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar может быть добавлен здесь, если он общий для всех экранов,
      // или в каждом отдельном экране для кастомизации.
      // appBar: AppBar(
      //   title: const Text('Meditation Harmony'),
      // ),
      
      // Тело Scaffold - отображает выбранный экран из списка _widgetOptions
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      
      // Нижняя навигационная панель в соответствии с ТЗ
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home), // Иконка для "Главная"
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.self_improvement), // Иконка для "Медитации"
            label: 'Медитации',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note), // Иконка для "Библиотека"
            label: 'Библиотека',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person), // Иконка для "Профиль"
            label: 'Профиль',
          ),
        ],
        currentIndex: _selectedIndex, // Текущий активный элемент
        onTap: _onItemTapped,       // Обработчик нажатий
        type: BottomNavigationBarType.fixed, // Фиксируем панель, чтобы все элементы были видны
      ),
    );
  }
}
