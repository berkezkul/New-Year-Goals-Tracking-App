import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../models/category_model.dart';
import '../models/goal_model.dart';
import '../services/database_service.dart';
import '../widgets/empty_state.dart';
import '../widgets/goal_card.dart';
import '../widgets/motivation_card.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  final DatabaseService _databaseService = DatabaseService();
  String _selectedCategory = 'all';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Motivasyon kartı
        const MotivationCard(),

        // Kategori filtreleme chips
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                FilterChip(
                  label: Text(AppLocalizations.of(context)!.categoryAll),
                  selected: _selectedCategory == 'all',
                  onSelected: (bool selected) {
                    setState(() {
                      _selectedCategory = 'all';
                    });
                  },
                  backgroundColor: Colors.white,
                  selectedColor: const Color(0xFFFF9966).withOpacity(0.2),
                  checkmarkColor: const Color(0xFFFF9966),
                  labelStyle: TextStyle(
                    color: _selectedCategory == 'all'
                        ? const Color(0xFFFF9966)
                        : Colors.black87,
                  ),
                  side: BorderSide(
                    color: _selectedCategory == 'all'
                        ? const Color(0xFFFF9966)
                        : Colors.grey.shade300,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const SizedBox(width: 8),
                ...CategoryData.categories.map((category) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: Text(CategoryData.getCategoryName(
                            category.name, context)),
                        selected: _selectedCategory == category.name,
                        onSelected: (bool selected) {
                          setState(() {
                            _selectedCategory = category.key;
                          });
                        },
                        backgroundColor: Colors.white,
                        selectedColor: const Color(0xFFFF9966).withOpacity(0.2),
                        checkmarkColor: const Color(0xFFFF9966),
                        labelStyle: TextStyle(
                          color: _selectedCategory == category.key
                              ? const Color(0xFFFF9966)
                              : Colors.black87,
                        ),
                        side: BorderSide(
                          color: _selectedCategory == category.key
                              ? const Color(0xFFFF9966)
                              : Colors.grey.shade300,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
        // Hedefler listesi
        Expanded(
          child: StreamBuilder<List<Goal>>(
            stream: _databaseService.getGoals(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Hata: ${snapshot.error}'));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              final goals = snapshot.data ?? [];
              final filteredGoals = _selectedCategory == 'all'
                  ? goals
                  : goals
                      .where((goal) => goal.category == _selectedCategory)
                      .toList();

              if (filteredGoals.isEmpty) {
                return EmptyState(
                  imagePath: 'assets/images/empty_goals.png',
                  message: AppLocalizations.of(context).noGoalsYet,
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: filteredGoals.length,
                itemBuilder: (context, index) {
                  final goal = filteredGoals[index];
                  return GoalCard(
                    goal: goal,
                    onTap: () {
                      _showGoalUpdateDialog(context, goal);
                    },
                    onProgressUpdate: (double newProgress) async {
                      final newAmount =
                          (newProgress * goal.targetAmount).round();
                      await _databaseService.updateGoalProgress(
                        goal.id,
                        newAmount,
                      );
                    },
                    categoryName:
                        CategoryData.getCategoryName(goal.category, context),
                    onLongPress: () {},
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  void _showGoalUpdateDialog(BuildContext context, Goal goal) {
    double tempProgress = goal.currentAmount / goal.targetAmount;

    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (context) => AlertDialog(
        title: Text(goal.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                '${AppLocalizations.of(context).goalProgress}: ${goal.currentAmount}/${goal.targetAmount}'),
            const SizedBox(height: 16),
            Slider(
              value: tempProgress,
              onChanged: (value) {
                tempProgress = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context).cancel),
          ),
          FilledButton(
            onPressed: () async {
              final newAmount = (tempProgress * goal.targetAmount).round();
              await _databaseService.updateGoalProgress(goal.id, newAmount);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(AppLocalizations.of(context).progressUpdated),
                    backgroundColor: Colors.green,
                  ),
                );
                Navigator.pop(context);
              }
            },
            child: Text(AppLocalizations.of(context).save),
          ),
        ],
      ),
    );
  }
}
