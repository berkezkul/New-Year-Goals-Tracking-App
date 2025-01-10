import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

class MotivationService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> initializeMotivationQuotes() async {
    final quotes = [
      {
        'text': 'Sağlıklı bir yaşam, mutlu bir gelecek.',
        'text_en': 'A healthy life leads to a happy future.',
        'category': 'health'
      },
      {
        'text': 'Her adım sizi hedefinize biraz daha yaklaştırır.',
        'text_en': 'Every step brings you closer to your goal.',
        'category': 'health'
      },
      {
        'text': 'Finansal özgürlük, akıllı kararlarla başlar.',
        'text_en': 'Financial freedom starts with smart decisions.',
        'category': 'finance'
      },
      {
        'text': 'Yatırım yapmak, geleceğe güvenmektir.',
        'text_en': 'Investing is trusting in the future.',
        'category': 'finance'
      },
      {
        'text': 'Kariyeriniz, tutkunuzun yansımasıdır.',
        'text_en': 'Your career is a reflection of your passion.',
        'category': 'career'
      },
      // Diğer kategoriler için de benzer şekilde eklenebilir
    ];

    final batch = _db.batch();

    for (var quote in quotes) {
      batch.set(_db.collection('motivation_quotes').doc(), quote);
    }

    await batch.commit();
  }

  static Stream<String> getRandomQuote(String category, String language) {
    return _db
        .collection('motivation_quotes')
        .where('category', isEqualTo: category)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isEmpty) return getDefaultQuote(language);

      final quotes = snapshot.docs;
      final randomQuote = quotes[Random().nextInt(quotes.length)].data();
      return language == 'en' ? randomQuote['text_en'] : randomQuote['text'];
    });
  }

  static String getDefaultQuote(String language) {
    return language == 'en'
        ? "Set your goals high and don't stop till you get there!"
        : "Hedeflerinizi yüksek tutun ve ulaşana kadar durmayın!";
  }
}
