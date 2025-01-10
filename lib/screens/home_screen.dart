import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../models/goal_model.dart';
import '../services/database_service.dart';
import '../widgets/empty_state.dart';
import '../widgets/goal_card.dart';
import '../widgets/notifications_sheet.dart';
import 'add_goal_screen.dart';
import '../services/motivation_service.dart';
import '../widgets/custom_bottom_nav.dart';
import '../screens/calendar_screen.dart';
import 'package:provider/provider.dart';
import '../providers/locale_provider.dart';
import '../providers/theme_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import 'goals_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const GoalsScreen(),
    const CalendarScreen(),
    NotificationsSheet(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)!.appTitle,
          style: GoogleFonts.inter(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => NotificationsSheet(),
                backgroundColor: Colors.transparent,
              );
            },
          ),
          IconButton(
            icon: Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return Icon(
                  themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                );
              },
            ),
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),
          PopupMenuButton<Locale>(
            icon: const Icon(Icons.language),
            onSelected: (Locale locale) {
              Provider.of<LocaleProvider>(context, listen: false)
                  .setLocale(locale);
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: Locale('tr', 'TR'),
                child: Text('Türkçe'),
              ),
              const PopupMenuItem(
                value: Locale('en', 'US'),
                child: Text('English'),
              ),
            ],
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddGoalScreen()),
          );
        },
        icon: const Icon(Icons.add),
        label: Text(AppLocalizations.of(context)!.addGoal),
      ),
    );
  }
}
