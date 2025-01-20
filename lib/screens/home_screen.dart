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
import 'daily_goals_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const GoalsScreen(),
    const CalendarScreen(),
    NotificationsSheet(),
    const DailyGoalsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: _screens[_currentIndex],
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            barrierColor: Colors.black54,
            useSafeArea: true,
            builder: (BuildContext context) {
              return Stack(
                children: [
                  IgnorePointer(
                    child: Opacity(
                      opacity: 0.7,
                      child: Container(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                  const AddGoalDialog(),
                ],
              );
            },
          );
        },
        backgroundColor: Colors.red,
        focusColor: Colors.orange,
        hoverColor: Colors.orangeAccent,
        icon: const Icon(Icons.add),
        label: Text(AppLocalizations.of(context).addGoal),
      ),
    );
  }
}
