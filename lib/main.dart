import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SmartMobileCodesApp());
}

class SmartMobileCodesApp extends StatelessWidget {
  const SmartMobileCodesApp({super.key});

  @override
  Widget build(BuildContext context) {
    const seed = Color(0xFF5B4BDB);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'كود موبايل',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.light),
        scaffoldBackgroundColor: const Color(0xFFF6F7FB),
        fontFamily: 'sans-serif',
        cardTheme: CardThemeData(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.dark),
        cardTheme: CardThemeData(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      ),
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
    );
  }
}
