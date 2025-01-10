import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/goal_model.dart';
import 'package:flutter/foundation.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String _collection = 'goals';

  // Hedef ekleme
  Future<void> addGoal(Goal goal) async {
    try {
      // Önce döküman referansı oluştur
      final docRef = _db.collection(_collection).doc();
      // ID'yi goal nesnesine ata
      final goalWithId = Goal(
        id: docRef.id, // Burada önemli değişiklik
        title: goal.title,
        category: goal.category,
        description: goal.description,
        dueDate: goal.dueDate,
        targetAmount: goal.targetAmount,
        currentAmount: goal.currentAmount,
        status: goal.status,
      );
      // Dökümanı kaydet
      await docRef.set(goalWithId.toMap());
    } catch (e) {
      debugPrint('Error adding goal: $e');
      rethrow;
    }
  }

  // Hedefleri getirme
  Stream<List<Goal>> getGoals() {
    return _db.collection(_collection).snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) {
            try {
              final data = doc.data();
              // Döküman ID'sini data map'e ekle
              data['id'] = doc.id;
              return Goal.fromMap(data);
            } catch (e) {
              debugPrint('Hata: ${doc.id} - $e');
              return null;
            }
          })
          .whereType<Goal>()
          .toList();
    });
  }

  // Hedef güncelleme
  Future<void> updateGoal(Goal goal) async {
    try {
      await _db.collection(_collection).doc(goal.id).update(goal.toMap());
    } catch (e) {
      debugPrint('Error updating goal: $e');
      rethrow;
    }
  }

  // Hedef silme
  Future<void> deleteGoal(String goalId) async {
    try {
      await _db.collection(_collection).doc(goalId).delete();
    } catch (e) {
      debugPrint('Error deleting goal: $e');
      rethrow;
    }
  }

  // Hedef durumunu güncelleme
  Future<void> updateGoalStatus(String goalId, GoalStatus status) async {
    try {
      final docRef = _db.collection(_collection).doc(goalId);
      // Önce dökümanın var olduğunu kontrol et
      final docSnapshot = await docRef.get();
      if (!docSnapshot.exists) {
        throw Exception('Hedef bulunamadı');
      }
      await docRef.update({
        'status': status.toString(),
      });
    } catch (e) {
      debugPrint('Error updating goal status: $e');
      throw Exception('Hedef durumu güncellenirken bir hata oluştu: $e');
    }
  }

  // Hedef ilerleme durumunu güncelleme
  Future<void> updateGoalProgress(String goalId, int newAmount) async {
    try {
      final docRef = _db.collection(_collection).doc(goalId);
      // Önce dökümanın var olduğunu kontrol et
      final docSnapshot = await docRef.get();
      if (!docSnapshot.exists) {
        throw Exception('Hedef bulunamadı');
      }
      await docRef.update({
        'currentAmount': newAmount,
      });
    } catch (e) {
      debugPrint('Error updating goal progress: $e');
      throw Exception('Hedef ilerlemesi güncellenirken bir hata oluştu: $e');
    }
  }
}
