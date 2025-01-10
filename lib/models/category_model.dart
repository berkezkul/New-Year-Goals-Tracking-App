import 'package:flutter/cupertino.dart';

import '../l10n/app_localizations.dart';

class Category {
  final String key;
  final String name;

  Category({required this.key, required this.name});
}

class CategoryData {
  static List<Category> categories = [
    Category(key: 'categoryHealth', name: 'Sağlık'),
    Category(key: 'categoryFinance', name: 'Finans'),
    Category(key: 'categoryCareer', name: 'Kariyer'),
    Category(key: 'categoryEducation', name: 'Eğitim'),
    Category(key: 'categorySports', name: 'Spor'),
    Category(key: 'categoryHobby', name: 'Hobi'),
    Category(key: 'categoryTravel', name: 'Seyahat'),
    Category(key: 'categoryPersonal', name: 'Kişisel'),
  ];

  static String getCategoryName(String key, BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    switch (key) {
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
        return key;
    }
  }
}
