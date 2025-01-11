import 'dart:math';

import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../models/goal_model.dart';
import '../services/database_service.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:confetti/confetti.dart';
import '../services/animation_service.dart';
import '../l10n/app_localizations.dart';

class AddGoalDialog extends StatefulWidget {
  const AddGoalDialog({super.key});

  @override
  State<AddGoalDialog> createState() => _AddGoalDialogState();
}

class _AddGoalDialogState extends State<AddGoalDialog> {
  final _formKey = GlobalKey<FormState>();
  final _databaseService = DatabaseService();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _targetAmountController = TextEditingController();
  late ConfettiController _confettiController;
  String _selectedCategory = 'categoryHealth';
  DateTime _dueDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _targetAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: isDarkMode ? const Color(0xFF1A237E) : Colors.white,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Başlık ve Kapat Butonu
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.addGoal,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black87,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: isDarkMode ? Colors.white70 : Colors.black54,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Resim
              Image.asset(
                'assets/images/add_goals.png',
                height: 120,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 24),

              // Form
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.goalTitle,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor:
                        isDarkMode ? Colors.white10 : Colors.grey.shade50,
                      ),
                      validator: (value) => _validateInput(
                        value,
                        AppLocalizations.of(context)!.goalTitle,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Kategori Seçimi
                    DropdownButtonFormField<String>(
                      value: _selectedCategory,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.goalCategory,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor:
                        isDarkMode ? Colors.white10 : Colors.grey.shade50,
                      ),
                      items: CategoryData.categories.map((category) {
                        return DropdownMenuItem<String>(
                          value: category.key,
                          child: Text(CategoryData.getCategoryName(
                              category.key, context)),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedCategory = newValue!;
                        });
                      },
                    ),
                    const SizedBox(height: 16),

                    // Hedef Miktarı
                    TextFormField(
                      controller: _targetAmountController,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context).goalTargetAmount,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor:
                        isDarkMode ? Colors.white10 : Colors.grey.shade50,
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) => _validateInput(
                        value,
                        AppLocalizations.of(context).goalTargetAmount,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildInputField(
                      controller: _descriptionController,
                      label: 'Açıklama',
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16),
                    _buildDatePicker(),
                    // Tarih Seçici
                    const SizedBox(height: 24),

                    // Kaydet Butonu
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _saveGoal,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF9966),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.save,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: label, // AppTheme.textLight
      ),
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$label boş bırakılamaz.';
        }
        return null;
      },
    );
  }


  // Mevcut yardımcı metodlar aynı kalacak
  Widget _buildDatePicker() {
    return ListTile(
      leading: const Icon(Icons.calendar_today, color: Color(0xFF2E5077)), // AppTheme.accentLight
      title: Text(
        'Son Tarih: ${DateFormat('dd/MM/yyyy').format(_dueDate)}',
        style: const TextStyle(fontSize: 16, color: Color(0xFF2E5077)), // AppTheme.textLight
      ),
      onTap: () async {
        final pickedDate = await showDatePicker(
          context: context,
          initialDate: _dueDate,
          firstDate: DateTime.now(),
          lastDate: DateTime(2025, 12, 31),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: const Color(0xFF4DA1A9), // AppTheme.primaryLight
                  onPrimary: Colors.white,
                  surface: const Color(0xFFFFFBF2), // AppTheme.cardLight
                  onSurface: const Color(0xFF2E5077), // AppTheme.textLight
                ),
              ),
              child: child!,
            );
          },
        );
        if (pickedDate != null) {
          setState(() {
            _dueDate = pickedDate;
          });
        }
      },
    );
  }



  void _saveGoal() async {
    if (_formKey.currentState!.validate()) {
      try {
        final goal = Goal(
          id: '',
          title: _titleController.text,
          category: _selectedCategory,
          description: _descriptionController.text,
          dueDate: _dueDate,
          targetAmount: int.parse(_targetAmountController.text),
          currentAmount: 0,
          status: GoalStatus.notStarted,
        );

        await _databaseService.addGoal(goal);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.messageGoalAdded),
              backgroundColor: Colors.green,
            ),
          );
          _confettiController.play();
          Navigator.pop(context);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Hata: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  String? _validateInput(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName boş bırakılamaz';
    }
    return null;
  }
}