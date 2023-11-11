import 'package:flutter/material.dart';
import 'base_screen.dart'; // Import the BaseScreen

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Track the theme mode
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleThemeMode(bool isOn) {
    setState(() {
      _themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Define the custom colors
    const Color primaryColor = Color(0xFF6750A4);
    const Color primaryContainer = Color(0xFFEADDFF);
    const Color secondaryColor = Color(0xFF625B71);
    const Color secondaryContainer = Color(0xFFE8DEF8);
    const Color tertiaryColor = Color(0xFF7D5260);
    const Color tertiaryContainer = Color(0xFFFFD8E4);

    return MaterialApp(
      title: 'Goal Tracker',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.light(
          primary: primaryColor,
          onPrimary: Colors.white,
          primaryContainer: primaryContainer,
          onPrimaryContainer: primaryColor,
          secondary: secondaryColor,
          onSecondary: Colors.white,
          secondaryContainer: secondaryContainer,
          onSecondaryContainer: secondaryColor,
          tertiary: tertiaryColor,
          onTertiary: Colors.white,
          tertiaryContainer: tertiaryContainer,
          onTertiaryContainer: tertiaryColor,
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.dark(
          primary: primaryColor,
          onPrimary: Colors.white,
          primaryContainer: primaryContainer,
          onPrimaryContainer: primaryColor,
          secondary: secondaryColor,
          onSecondary: Colors.white,
          secondaryContainer: secondaryContainer,
          onSecondaryContainer: secondaryColor,
          tertiary: tertiaryColor,
          onTertiary: Colors.white,
          tertiaryContainer: tertiaryContainer,
          onTertiaryContainer: tertiaryColor,
          surface: Color(0xFF121212),
        ),
        scaffoldBackgroundColor: Color(0xFF121212),
      ),
      themeMode: _themeMode,
      home: BaseScreen(toggleTheme: _toggleThemeMode),
    );
  }
}
