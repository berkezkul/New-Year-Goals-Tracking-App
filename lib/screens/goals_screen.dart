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
        MotivationCard(),

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
                  backgroundColor: Theme.of(context).chipTheme.backgroundColor,
                  selectedColor: Theme.of(context).chipTheme.selectedColor,
                  labelStyle: Theme.of(context).chipTheme.labelStyle,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const SizedBox(width: 8),
                ...CategoryData.categories.map((category) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: Text(CategoryData.getCategoryName(
                            category.key, context)),
                        selected: _selectedCategory == category.key,
                        onSelected: (bool selected) {
                          setState(() {
                            _selectedCategory = category.key;
                          });
                        },
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
                  message: AppLocalizations.of(context)!.noGoalsYet,
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
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(goal.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                '${AppLocalizations.of(context)!.goalProgress}: ${goal.currentAmount}/${goal.targetAmount}'),
            const SizedBox(height: 16),
            Slider(
              value: goal.currentAmount / goal.targetAmount,
              onChanged: (value) async {
                final newAmount = (value * goal.targetAmount).round();
                await _databaseService.updateGoalProgress(goal.id, newAmount);
                Navigator.pop(context);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
        ],
      ),
    );
  }
}
