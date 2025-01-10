import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Yılbaşı Hedefleri';

  @override
  String get goals => 'Hedefler';

  @override
  String get notifications => 'Bildirimler';

  @override
  String get statistics => 'İstatistikler';

  @override
  String get addGoal => 'Yeni Hedef';

  @override
  String get categoryAll => 'Tümü';

  @override
  String get categoryHealth => 'Sağlık';

  @override
  String get categoryFinance => 'Finans';

  @override
  String get categoryCareer => 'Kariyer';

  @override
  String get categoryEducation => 'Eğitim';

  @override
  String get categorySports => 'Spor';

  @override
  String get categoryHobby => 'Hobi';

  @override
  String get categoryTravel => 'Seyahat';

  @override
  String get categoryPersonal => 'Kişisel';

  @override
  String get goalTitle => 'Başlık';

  @override
  String get goalCategory => 'Kategori';

  @override
  String get goalDescription => 'Açıklama';

  @override
  String get goalTargetAmount => 'Hedef Miktar';

  @override
  String get goalDueDate => 'Bitiş Tarihi';

  @override
  String get settingsLanguage => 'Dil';

  @override
  String get settingsTheme => 'Tema';

  @override
  String get settingsDarkMode => 'Karanlık Mod';

  @override
  String get settingsLightMode => 'Aydınlık Mod';

  @override
  String get messageGoalAdded => 'Hedef başarıyla eklendi!';

  @override
  String get messageGoalUpdated => 'Hedef güncellendi';

  @override
  String get messageGoalDeleted => 'Hedef silindi';

  @override
  String messageError(String error) {
    return 'Hata oluştu: $error';
  }

  @override
  String get addNewGoalCard => '✨ Hayallerinizi gerçeğe dönüştürmeye hazır mısınız?\nYeni bir hedef ekleyin ve başlayın! 🎯';

  @override
  String get noGoalsYet => 'Henüz hedef eklenmemiş';

  @override
  String noGoalsInCategory(String category) {
    return '$category kategorisinde hedef bulunmuyor';
  }

  @override
  String get progressUpdated => 'İlerleme güncellendi';

  @override
  String updateFailed(String error) {
    return 'Güncelleme başarısız: $error';
  }

  @override
  String get categories => 'Kategoriler';

  @override
  String get home => 'Ana Sayfa';

  @override
  String get calendar => 'Takvim';

  @override
  String get settings => 'Ayarlar';

  @override
  String get selectCategory => 'Kategori Seçin';

  @override
  String get enterTitle => 'Başlık Girin';

  @override
  String get enterDescription => 'Açıklama Girin';

  @override
  String get enterAmount => 'Miktar Girin';

  @override
  String get selectDate => 'Tarih Seçin';

  @override
  String get save => 'Kaydet';

  @override
  String get cancel => 'İptal';

  @override
  String get delete => 'Sil';

  @override
  String get edit => 'Düzenle';

  @override
  String get confirmDelete => 'Silmek istediğinize emin misiniz?';

  @override
  String get yes => 'Evet';

  @override
  String get no => 'Hayır';

  @override
  String get goalProgress => 'Hedef İlerlemesi';

  @override
  String get completed => 'Tamamlandı';

  @override
  String get inProgress => 'Devam Ediyor';

  @override
  String get notStarted => 'Başlanmadı';

  @override
  String daysLeft(int days) {
    return 'Kalan Gün: $days';
  }

  @override
  String get motivationQuote => 'Motivasyon Sözü';

  @override
  String get addCategory => 'Kategori Ekle';

  @override
  String get categoryName => 'Kategori Adı';

  @override
  String get categoryExists => 'Bu kategori zaten mevcut';

  @override
  String get categoryAdded => 'Kategori eklendi';

  @override
  String get categoryDeleted => 'Kategori silindi';

  @override
  String get noCategorySelected => 'Kategori seçilmedi';

  @override
  String getString(String key) {
    return '$key';
  }

  @override
  String get currentProgress => 'Mevcut İlerleme';
}
