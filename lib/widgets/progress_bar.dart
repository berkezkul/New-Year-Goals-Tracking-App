import 'package:flutter/material.dart';

class CustomProgressBar extends StatelessWidget {
  final double progress;
  final Function(int) onProgressUpdate;
  final int currentAmount;
  final int targetAmount;

  const CustomProgressBar({
    Key? key,
    required this.progress,
    required this.onProgressUpdate,
    required this.currentAmount,
    required this.targetAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey[200],
          valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF008000)),
          minHeight: 10,
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('$currentAmount / $targetAmount'),
            TextButton(
              onPressed: () => _showUpdateDialog(context),
              child: const Text('İlerlemeyi Güncelle'),
            ),
          ],
        ),
      ],
    );
  }

  void _showUpdateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        int updatedAmount = currentAmount;
        return AlertDialog(
          title: const Text('İlerlemeyi Güncelle'),
          content: TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              updatedAmount = int.tryParse(value) ?? currentAmount;
            },
            decoration: InputDecoration(
              labelText: 'Yeni Miktar',
              hintText: 'Şu anki miktar: $currentAmount',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('İptal'),
            ),
            TextButton(
              onPressed: () {
                onProgressUpdate(updatedAmount);
                Navigator.pop(context);
              },
              child: const Text('Güncelle'),
            ),
          ],
        );
      },
    );
  }
}
