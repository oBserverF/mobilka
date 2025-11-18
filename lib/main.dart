
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'providers/music_provider.dart';
import 'screens/home_screen.dart';
import 'screens/meditations_screen.dart';
import 'screens/library_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MusicProvider(),
      child: const MeditationHarmonyApp(),
    ),
  );
}

class MeditationHarmonyApp extends StatelessWidget {
  const MeditationHarmonyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const Color seedColor = Color(0xFFB9E4C9); // A gentle, light green

    return MaterialApp(
      title: 'Meditation Harmony',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.light,
          primary: seedColor,
          onPrimary: Colors.black87,
          secondary: const Color(0xFFD4F1DD),
          onSecondary: Colors.black87,
          surface: const Color(0xFFFAFFF8),
        ),
        scaffoldBackgroundColor: const Color(0xFFF5FBF7),
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ).apply(
          bodyColor: Colors.black87,
          displayColor: Colors.black87,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.black87,
          titleTextStyle: GoogleFonts.montserrat(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      home: const MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    MeditationsScreen(),
    LibraryScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: _buildFrostedNavBar(),
    );
  }

  Widget _buildFrostedNavBar() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(25.0),
        topRight: Radius.circular(25.0),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withAlpha(179),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            ),
            border: Border(
              top: BorderSide(
                color: Theme.of(context).colorScheme.primary.withAlpha(51),
                width: 1.0,
              ),
            ),
          ),
          child: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              _buildNavItem(Icons.home_rounded, 'Главная', 0),
              _buildNavItem(Icons.self_improvement_rounded, 'Медитации', 1),
              _buildNavItem(Icons.music_note_rounded, 'Библиотека', 2),
              _buildNavItem(Icons.person_outline_rounded, 'Профиль', 3),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(IconData icon, String label, int index) {
    final bool isSelected = _selectedIndex == index;
    final color = isSelected ? Theme.of(context).colorScheme.primary : Colors.grey[400];

    return BottomNavigationBarItem(
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: isSelected
            ? BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withAlpha(51),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.primary.withAlpha(128),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              )
            : null,
        child: Icon(icon, color: color),
      ),
      label: label,
    );
  }
}
