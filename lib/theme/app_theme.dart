import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Modern renk paleti
  static const Color primaryLight = Color(0xFF000000);
  static const Color secondaryLight = Color(0xFFFF9966);
  static const Color accentLight = Color(0xFFFFD93D);
  static const Color surfaceLight = Color(0xFFF4F3EE);
  static const Color cardLight = Color(0xFFFFFBF2);

  // Dark tema renkleri
  static const Color primaryDark = Color(0xFF000000);
  static const Color secondaryDark = Color(0xFFFF9966);
  static const Color accentDark = Color(0xFFFFD93D);
  static const Color surfaceDark = Color(0xFF121212);
  static const Color cardDark = Color(0xFF1E1E1E);

  // Kategori renkleri
  static const Map<String, Color> categoryColors = {
    'categoryHealth': Color(0xFFFF9966), // Turuncu
    'categoryFinance': Color(0xFFFFD93D), // Sarı
    'categoryCareer': Color(0xFFE6E6FA), // Lavanta
    'categoryEducation': Color(0xFFFFE4E1), // Açık pembe
    'categorySports': Color(0xFFE0FFFF), // Açık turkuaz
    'categoryHobby': Color(0xFFFFF0F5), // Lavanta pembesi
    'categoryTravel': Color(0xFFF0FFF0), // Açık yeşil
    'categoryPersonal': Color(0xFFFFFACD), // Açık sarı
  };

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primaryLight,
      scaffoldBackgroundColor: surfaceLight,

      // Card teması
      cardTheme: CardTheme(
        elevation: 0,
        color: cardLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),

      // AppBar teması
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: surfaceLight,
        centerTitle: true,
        titleTextStyle: GoogleFonts.inter(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),

      // Chip teması
      chipTheme: ChipThemeData(
        backgroundColor: Colors.black.withOpacity(0.08),
        selectedColor: Colors.black,
        labelStyle: GoogleFonts.inter(
          fontSize: 14,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),

      // Text teması
      textTheme: TextTheme(
        headlineLarge: GoogleFonts.inter(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        titleLarge: GoogleFonts.inter(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 16,
          color: Colors.black87,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          color: Colors.black54,
        ),
      ),

      // Input dekorasyon teması
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.black.withOpacity(0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.black, width: 1),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        labelStyle: const TextStyle(color: Colors.black54),
        hintStyle: const TextStyle(color: Colors.black38),
      ),

      // FloatingActionButton teması
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      // ElevatedButton teması
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: primaryDark,
      scaffoldBackgroundColor: surfaceDark,

      // Card teması
      cardTheme: CardTheme(
        elevation: 0,
        color: Colors.white.withOpacity(0.05),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),

      // AppBar teması
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: surfaceDark,
        centerTitle: true,
        titleTextStyle: GoogleFonts.inter(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      // Chip teması
      chipTheme: ChipThemeData(
        backgroundColor: Colors.white.withOpacity(0.08),
        selectedColor: Colors.white,
        labelStyle: GoogleFonts.inter(
          fontSize: 14,
          color: Colors.white,
        ),
      ),

      // Text teması
      textTheme: TextTheme(
        titleLarge: GoogleFonts.inter(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 16,
          color: Colors.white.withOpacity(0.87),
        ),
      ),
    );
  }
}

// Özel tema extension'ı
class CustomThemeExtension extends ThemeExtension<CustomThemeExtension> {
  final Map<String, List<Color>> cardGradients;

  CustomThemeExtension({
    required this.cardGradients,
  });

  @override
  ThemeExtension<CustomThemeExtension> copyWith({
    Map<String, List<Color>>? cardGradients,
  }) {
    return CustomThemeExtension(
      cardGradients: cardGradients ?? this.cardGradients,
    );
  }

  @override
  ThemeExtension<CustomThemeExtension> lerp(
    ThemeExtension<CustomThemeExtension>? other,
    double t,
  ) {
    if (other is! CustomThemeExtension) {
      return this;
    }
    return CustomThemeExtension(
      cardGradients: cardGradients,
    );
  }
}
