import 'package:flutter/material.dart';
import '../models/goal_model.dart';
import '../services/database_service.dart';
import '../theme/app_theme.dart';
import '../widgets/empty_state.dart';
import '../widgets/goal_card.dart';

class DailyGoalsScreen extends StatefulWidget {
  const DailyGoalsScreen({super.key});

  @override
  State<DailyGoalsScreen> createState() => _DailyGoalsScreenState();
}

class _DailyGoalsScreenState extends State<DailyGoalsScreen> {
  final DatabaseService _databaseService = DatabaseService();
  DateTime _selectedMonth = DateTime.now();

  @override
  void initState() {
    super.initState();
    // Sayfa açıldığında hedefleri kontrol et
    _checkAndUpdateGoals();
  }

  // Hedefleri kontrol et ve gerekirse güncelle
  Future<void> _checkAndUpdateGoals() async {
    final goals = await _databaseService.getGoals().first;
    for (final goal in goals) {
      // Eğer hedef tamamlanmış görünüyorsa ama status'u completed değilse
      if (goal.currentAmount >= goal.targetAmount &&
          goal.status != GoalStatus.completed) {
        await _databaseService.updateGoalStatus(goal.id, GoalStatus.completed);
      }
      // Eğer hedef tamamlanmamış görünüyorsa ama status'u completed ise
      else if (goal.currentAmount < goal.targetAmount &&
          goal.status == GoalStatus.completed) {
        await _databaseService.updateGoalStatus(goal.id, GoalStatus.ongoing);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Üst kısım - Ay seçici ve ilerleme
          Container(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
            decoration: const BoxDecoration(
              color: AppTheme.primaryLight,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                // Ay ve yıl gösterimi
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left, color: Colors.white),
                      onPressed: () => _changeMonth(-1),
                    ),
                    Text(
                      _formatMonth(_selectedMonth),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon:
                          const Icon(Icons.chevron_right, color: Colors.white),
                      onPressed: () => _changeMonth(1),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // İlerleme göstergesi
                StreamBuilder<List<Goal>>(
                  stream: _databaseService.getGoals(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator(
                          color: Colors.white);
                    }

                    final goals = snapshot.data!;
                    // Her build'de hedefleri kontrol et
                    _checkAndUpdateGoals();

                    final monthlyGoals = goals.where((goal) {
                      return goal.dueDate.year == _selectedMonth.year &&
                          goal.dueDate.month == _selectedMonth.month;
                    }).toList();

                    final completedGoals = monthlyGoals
                        .where((goal) => goal.status == GoalStatus.completed)
                        .length;

                    final progress = monthlyGoals.isEmpty
                        ? 0.0
                        : completedGoals / monthlyGoals.length;

                    return Column(
                      children: [
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: CircularProgressIndicator(
                            value: progress,
                            backgroundColor: Colors.white24,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.white),
                            strokeWidth: 8,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '$completedGoals/${monthlyGoals.length} Hedef Tamamlandı',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          // Hedefler listesi
          Expanded(
            child: StreamBuilder<List<Goal>>(
              stream: _databaseService.getGoals(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final goals = snapshot.data!;
                final monthlyGoals = goals.where((goal) {
                  return goal.dueDate.year == _selectedMonth.year &&
                      goal.dueDate.month == _selectedMonth.month;
                }).toList();

                if (monthlyGoals.isEmpty) {
                  return const EmptyState(
                    imagePath: 'assets/images/empty_goals.png',
                    message: 'Bu ay için hedef bulunmuyor',
                  );
                }

                return ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: monthlyGoals.length,
                  itemBuilder: (context, index) {
                    final goal = monthlyGoals[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: GoalCard(
                        goal: goal,
                        onTap: () {},
                        onLongPress: () {},
                        onProgressUpdate: (double newProgress) async {
                          final newAmount =
                              (newProgress * goal.targetAmount).round();
                          try {
                            await _databaseService.updateGoalProgress(
                                goal.id, newAmount);
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Hata: $e'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        },
                        categoryName: goal.category,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _changeMonth(int months) {
    setState(() {
      _selectedMonth = DateTime(
        _selectedMonth.year,
        _selectedMonth.month + months,
      );
    });
  }

  String _formatMonth(DateTime date) {
    final months = [
      'Ocak',
      'Şubat',
      'Mart',
      'Nisan',
      'Mayıs',
      'Haziran',
      'Temmuz',
      'Ağustos',
      'Eylül',
      'Ekim',
      'Kasım',
      'Aralık'
    ];
    return '${months[date.month - 1]} ${date.year}';
  }
}
