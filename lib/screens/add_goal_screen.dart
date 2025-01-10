import 'dart:math';

import 'package:flutter/material.dart';
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

class AddGoalScreen extends StatefulWidget {
  const AddGoalScreen({Key? key}) : super(key: key);

  @override
  State<AddGoalScreen> createState() => _AddGoalScreenState();
}

class _AddGoalScreenState extends State<AddGoalScreen> {
  final _formKey = GlobalKey<FormState>();
  final _databaseService = DatabaseService();
  final _titleController = TextEditingController();
  final _categoryController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _targetAmountController = TextEditingController();

  DateTime _dueDate = DateTime.now();
  final List<String> _categories = [
    'categoryHealth',
    'categoryFinance',
    'categoryCareer',
    'categoryEducation',
    'categorySports',
    'categoryHobby',
    'categoryTravel',
    'categoryPersonal'
  ];

  late ConfettiController _confettiController;
  String _selectedCategory = 'categoryHealth';

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
    _categoryController.dispose();
    _descriptionController.dispose();
    _targetAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.addGoal),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _buildInputField(
                          controller: _titleController,
                          label: AppLocalizations.of(context)!.goalTitle,
                          icon: Icons.title,
                        ),
                        const SizedBox(height: 16),
                        _buildCategoryPicker(),
                        const SizedBox(height: 16),
                        _buildInputField(
                          controller: _descriptionController,
                          label: AppLocalizations.of(context)!.goalDescription,
                          icon: Icons.description,
                          maxLines: 3,
                        ),
                        const SizedBox(height: 16),
                        _buildInputField(
                          controller: _targetAmountController,
                          label: AppLocalizations.of(context)!.goalTargetAmount,
                          icon: Icons.track_changes,
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 16),
                        _buildDatePicker(),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _saveGoal,
                icon: const Icon(Icons.save),
                label: Text(AppLocalizations.of(context)!.save),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
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
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: (value) => _validateInput(value, label),
    );
  }

  Widget _buildDatePicker() {
    return ListTile(
      leading: const Icon(Icons.calendar_today),
      title: Text(
        'Son Tarih: ${DateFormat('dd/MM/yyyy').format(_dueDate)}',
        style: const TextStyle(fontSize: 16),
      ),
      onTap: () async {
        final DateTime now = DateTime.now();
        final DateTime firstDate = now;
        final DateTime lastDate = DateTime(2025, 12, 31);

        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: _dueDate,
          firstDate: firstDate,
          lastDate: lastDate,
          locale: const Locale('tr', 'TR'),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: Theme.of(context).primaryColor,
                  onPrimary: Colors.white,
                  surface: Colors.white,
                  onSurface: Colors.black,
                ),
              ),
              child: child!,
            );
          },
        );

        if (picked != null) {
          setState(() {
            _dueDate = picked;
          });
        }
      },
    );
  }

  Future<void> _saveGoal() async {
    if (_formKey.currentState!.validate()) {
      try {
        debugPrint('Hedef kaydediliyor...');
        debugPrint('Seçili kategori: $_selectedCategory');

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

        debugPrint('Oluşturulan hedef: ${goal.toMap()}');
        await _databaseService.addGoal(goal);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.messageGoalAdded),
              backgroundColor: Colors.green,
            ),
          );
          _confettiController.play();
        }
      } catch (e) {
        debugPrint('Hedef kaydetme hatası: $e');
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

  String _getCategoryName(String categoryKey) {
    final localizations = AppLocalizations.of(context)!;
    switch (categoryKey) {
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
        return categoryKey;
    }
  }

  Widget _buildCategoryPicker() {
    final localizations = AppLocalizations.of(context)!;
    final categories = [
      'categoryHealth',
      'categoryFinance',
      'categoryCareer',
      'categoryEducation',
      'categorySports',
      'categoryHobby',
      'categoryTravel',
      'categoryPersonal',
    ];

    return DropdownButtonFormField<String>(
      value: _selectedCategory,
      decoration: InputDecoration(
        labelText: localizations.goalCategory,
      ),
      items: categories.map((String categoryKey) {
        return DropdownMenuItem<String>(
          value: categoryKey,
          child: Text(_getCategoryName(categoryKey)),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _selectedCategory = newValue!;
        });
      },
      validator: (value) =>
      value == null ? localizations.noCategorySelected : null,
    );
  }
}