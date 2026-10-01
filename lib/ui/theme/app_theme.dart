import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme{
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF1E3A8A),
        surface: Colors.grey[50],
      ),
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black87,
      ),
    );
  }
}