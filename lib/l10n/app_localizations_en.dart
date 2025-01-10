import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'New Year Goals';

  @override
  String get goals => 'Goals';

  @override
  String get notifications => 'Notifications';

  @override
  String get statistics => 'Statistics';

  @override
  String get addGoal => 'New Goal';

  @override
  String get categoryAll => 'All';

  @override
  String get categoryHealth => 'Health';

  @override
  String get categoryFinance => 'Finance';

  @override
  String get categoryCareer => 'Career';

  @override
  String get categoryEducation => 'Education';

  @override
  String get categorySports => 'Sports';

  @override
  String get categoryHobby => 'Hobby';

  @override
  String get categoryTravel => 'Travel';

  @override
  String get categoryPersonal => 'Personal';

  @override
  String get goalTitle => 'Title';

  @override
  String get goalCategory => 'Category';

  @override
  String get goalDescription => 'Description';

  @override
  String get goalTargetAmount => 'Target Amount';

  @override
  String get goalDueDate => 'Due Date';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsTheme => 'Theme';

  @override
  String get settingsDarkMode => 'Dark Mode';

  @override
  String get settingsLightMode => 'Light Mode';

  @override
  String get messageGoalAdded => 'Goal added successfully!';

  @override
  String get messageGoalUpdated => 'Goal updated';

  @override
  String get messageGoalDeleted => 'Goal deleted';

  @override
  String messageError(String error) {
    return 'Error occurred: $error';
  }

  @override
  String get addNewGoalCard => '✨ Ready to turn your dreams into reality?\nAdd a new goal and get started! 🎯';

  @override
  String get noGoalsYet => 'No goals added yet';

  @override
  String noGoalsInCategory(String category) {
    return 'No goals in $category category';
  }

  @override
  String get progressUpdated => 'Progress updated';

  @override
  String updateFailed(String error) {
    return 'Update failed: $error';
  }

  @override
  String get categories => 'Categories';

  @override
  String get home => 'Home';

  @override
  String get calendar => 'Calendar';

  @override
  String get settings => 'Settings';

  @override
  String get selectCategory => 'Select Category';

  @override
  String get enterTitle => 'Enter Title';

  @override
  String get enterDescription => 'Enter Description';

  @override
  String get enterAmount => 'Enter Amount';

  @override
  String get selectDate => 'Select Date';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get confirmDelete => 'Are you sure you want to delete?';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get goalProgress => 'Goal Progress';

  @override
  String get completed => 'Completed';

  @override
  String get inProgress => 'In Progress';

  @override
  String get notStarted => 'Not Started';

  @override
  String daysLeft(int days) {
    return 'Days Left: $days';
  }

  @override
  String get motivationQuote => 'Add, Track, Complete Your Goals!';

  @override
  String get addCategory => 'Add Category';

  @override
  String get categoryName => 'Category Name';

  @override
  String get categoryExists => 'This category already exists';

  @override
  String get categoryAdded => 'Category added';

  @override
  String get categoryDeleted => 'Category deleted';

  @override
  String get noCategorySelected => 'No category selected';

  @override
  String getString(String key) {
    return '$key';
  }

  @override
  String get currentProgress => 'Current Progress';
}
