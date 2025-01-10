import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:new_year_goals_app/l10n/app_localizations.dart';
import 'package:new_year_goals_app/models/goal_model.dart';
import 'package:new_year_goals_app/services/database_service.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final DatabaseService _databaseService = DatabaseService();
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  List<Goal> _goals = [];

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = _focusedDay;
    _loadGoals();
  }

  Future<void> _loadGoals() async {
    try {
      final goalsList = await _databaseService.getGoals().first;
      if (mounted) {
        setState(() {
          _goals = goalsList;
        });
      }
    } catch (e) {
      debugPrint('Hedefler yüklenirken hata: $e');
    }
  }

  String _getCategoryName(String category) {
    final localizations = AppLocalizations.of(context)!;
    switch (category) {
      case 'categoryHealth':
        return localizations.categoryHealth;
      case 'categoryFinance':
        return localizations.categoryFinance;
      case 'categoryCareer':
        return localizations.categoryCareer;
      case 'categoryEducation':
        return localizations.categoryEducation;
      case 'categorySports':
        return localizations.categorySports;
      case 'categoryHobby':
        return localizations.categoryHobby;
      case 'categoryTravel':
        return localizations.categoryTravel;
      case 'categoryPersonal':
        return localizations.categoryPersonal;
      default:
        return category;
    }
  }

  List<Goal> _getGoalsForDay(DateTime day) {
    return _goals.where((goal) {
      return isSameDay(goal.dueDate, day);
    }).toList();
  }

  Widget _buildStatusIcon(GoalStatus status) {
    IconData iconData;
    Color color;

    switch (status) {
      case GoalStatus.completed:
        iconData = Icons.check_circle;
        color = Colors.green;
        break;
      case GoalStatus.ongoing:
        iconData = Icons.access_time;
        color = Colors.blue;
        break;
      case GoalStatus.notStarted:
        iconData = Icons.radio_button_unchecked;
        color = Colors.grey;
        break;
      case GoalStatus.cancelled:
        iconData = Icons.cancel;
        color = Colors.red;
        break;
    }

    return Icon(iconData, color: color);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Takvim'),
      ),
      body: Column(
        children: [
          TableCalendar<Goal>(
            firstDay: DateTime(DateTime.now().year, 1, 1),
            lastDay: DateTime(DateTime.now().year, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            eventLoader: _getGoalsForDay,
            calendarFormat: CalendarFormat.month,
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: CalendarStyle(
              markerDecoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
              markerSize: 8,
              markersMaxCount: 4,
              markerMargin: const EdgeInsets.symmetric(horizontal: 0.3),
              selectedDecoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              markerSizeScale: 0.2,
              markersAnchor: 1.7,
              weekendTextStyle: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: _buildGoalsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalsList() {
    final goalsForDay = _getGoalsForDay(_selectedDay);

    if (goalsForDay.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                Theme.of(context).primaryColor.withOpacity(0.5),
                BlendMode.srcATop,
              ),
              child: Image.asset(
                'assets/images/empty_goals.png',
                width: 200,
                height: 200,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Hedef Yok",
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      itemCount: goalsForDay.length,
      itemBuilder: (context, index) {
        final goal = goalsForDay[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            title: Text(
              goal.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(goal.description),
                const SizedBox(height: 4),
                Text(
                  _getCategoryName(goal.category),
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            trailing: _buildStatusIcon(goal.status),
          ),
        );
      },
    );
  }
}
