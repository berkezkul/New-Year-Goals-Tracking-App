import 'package:flutter/cupertino.dart';
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
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.flag_outlined),
          activeIcon: const Icon(Icons.flag),
          label: AppLocalizations.of(context)!.goals,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.calendar_today_outlined),
          activeIcon: const Icon(Icons.calendar_today),
          label: AppLocalizations.of(context)!.calendar,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.insert_chart_outlined),
          activeIcon: const Icon(Icons.insert_chart),
          label: AppLocalizations.of(context)!.statistics,
        ),
      ],
    );
  }
}
