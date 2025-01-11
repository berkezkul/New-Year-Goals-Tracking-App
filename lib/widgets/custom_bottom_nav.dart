import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white, // Arka plan rengi
      selectedItemColor: Colors.blue.shade700, // Seçili öğe rengi
      unselectedItemColor: Colors.grey, // Seçili olmayan öğe rengi
      selectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 12,
      ),
      elevation: 0,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.flag_outlined),
          activeIcon: const Icon(Icons.flag),
          label: AppLocalizations.of(context).goals,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.calendar_today_outlined),
          activeIcon: const Icon(Icons.calendar_today),
          label: AppLocalizations.of(context).calendar,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.insert_chart_outlined),
          activeIcon: const Icon(Icons.insert_chart),
          label: AppLocalizations.of(context).statistics,
        ),
      ],
    );
  }
}
