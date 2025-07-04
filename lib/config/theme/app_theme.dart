import 'package:flutter/material.dart';

class AppTheme {
  static const Color _primaryColor = Color(0xFF6750A4); // Morado elegante
  static const Color _secondaryColor = Color(0xFF03DAC6); // Verde azulado
  static const Color _errorColor = Color(0xFFB00020); // Rojo oscuro
  static const Color _backgroundColor = Color(0xFFF8F5FF); // Fondo claro con tinte morado

  static final ThemeData theme = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: _primaryColor,
      onPrimary: Colors.white,
      secondary: _secondaryColor,
      onSecondary: Colors.black,
      error: _errorColor,
      onError: Colors.white,
      background: _backgroundColor,
      onBackground: Colors.black87,
      surface: Colors.white,
      onSurface: Colors.black87,
    ),

    // Personalización de tipografía
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.5,
      ),
      displayMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.15,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        letterSpacing: 0.15,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        letterSpacing: 0.25,
      ),
    ),

    // Personalización de botones
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 2,
      ),
    ),

    // Personalización de tarjetas
    cardTheme: CardThemeData(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.all(8),
    ),

    // Personalización de campos de texto
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey.shade50,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _errorColor, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),

    // Efectos de interacción
    splashFactory: InkRipple.splashFactory,
    splashColor: _primaryColor.withOpacity(0.1),
    highlightColor: _primaryColor.withOpacity(0.05),

    // Iconos
    iconTheme: const IconThemeData(
      color: _primaryColor,
      size: 24,
    ),

    // AppBar
    appBarTheme: const AppBarTheme(
      backgroundColor: _primaryColor,
      foregroundColor: Colors.white,
      centerTitle: false,
      elevation: 0,
      scrolledUnderElevation: 4,
    ),

    // Barra de navegación
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: _primaryColor,
      unselectedItemColor: Colors.black54,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
  );
}
