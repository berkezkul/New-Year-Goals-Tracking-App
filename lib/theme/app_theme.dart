import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Modern ve soft renk paleti (60-30-10 kuralına göre)
  // Ana renk (60%)
  static const Color primaryLight = Color(0xFF4DA1A9); // Soft mavi
  static const Color backgroundLight = Color(0xFFF5EFE7);

  // İkincil renk (30%)
  static const Color secondaryLight = Color(0xFF79D7BE); // Soft yeşil
  static const Color surfaceLight = Color(0xFFFFFFFF);

  // Aksan renk (10%)
  static const Color accentLight = Color(0xFF2E5077); // Koyu mavi

  // Kart ve diğer renkler
  static const Color cardLight = Color(0xFFFFFBF2);
  static const Color textLight = Color(0xFF2E5077);

  // Dark tema renkleri
  static const Color primaryDark = Color(0xFF79D7BE);
  static const Color backgroundDark = Color(0xFF213555);
  static const Color secondaryDark = Color(0xFF4DA1A9);
  static const Color surfaceDark = Color(0xFF012351);
  static const Color accentDark = Color(0xFFF5EFE7);
  static const Color cardDark = Color(0xFF2E5077);
  static const Color textDark = Color(0xFFF5EFE7);

  // Kategori renkleri
  static const Map<String, Color> categoryColors = {
    'categoryHealth': Color(0xFF79D7BE), // Soft yeşil
    'categoryFinance': Color(0xFF4DA1A9), // Soft mavi
    'categoryCareer': Color(0xFF2E5077), // Koyu mavi
    'categoryEducation': Color(0xFF6F9EAF), // Orta mavi
    'categorySports': Color(0xFF90C8AC), // Açık yeşil
    'categoryHobby': Color(0xFF8EB8E5), // Açık mavi
    'categoryTravel': Color(0xFF7DA9C7), // Gök mavisi
    'categoryPersonal': Color(0xFF86A7C3), // Gri mavi
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
          color: surfaceDark,
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
        color: cardLight,
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
          color: secondaryDark,
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
          color: primaryDark,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 16,
          color: secondaryDark,
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
