import 'package:flutter/material.dart';
import '../models/goal_model.dart';
import 'progress_bar.dart';
import '../theme/app_theme.dart';

class GoalCard extends StatelessWidget {
  final Goal goal;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const GoalCard({
    Key? key,
    required this.goal,
    required this.onTap,
    required this.onLongPress, required Future<Null> Function(double newProgress) onProgressUpdate, required String categoryName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final progress = goal.currentAmount / goal.targetAmount;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: goal.currentAmount >= goal.targetAmount
              ? Colors.green.withOpacity(0.1)
              : const Color(0xFFFF9966).withOpacity(0.1),
        ),
        child: ListTile(
          onTap: onTap,
          onLongPress: onLongPress,
          contentPadding: const EdgeInsets.all(16),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      goal.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppTheme.surfaceDark,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  Text(
                    '${goal.currentAmount}/${goal.targetAmount}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.surfaceDark),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey.withOpacity(0.2),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      goal.currentAmount >= goal.targetAmount
                          ? Colors.green
                          : const Color(0xFFFF9966),
                    ),
                    minHeight: 8,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    goal.category,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold,
                          color: isDarkMode ? AppTheme.surfaceDark : Colors.black54,
                        ),
                  ),
                  Text(
                    _formatDueDate(goal.dueDate),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold,
                          color: isDarkMode ? AppTheme.secondaryDark : Colors.black54, fontSize: 14
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDueDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
