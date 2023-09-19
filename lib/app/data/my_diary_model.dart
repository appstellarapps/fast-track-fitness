class MyDiaryModel {}

class DiaryItem {
  final int id;
  final String image;
  final String title;
  String description;

  DiaryItem({required this.id, required this.image, required this.title, required this.description});
}

class DiaryStatsItem {
  final int id;
  final String image;
  final String title;
  final String titleColor;
  final String firstValue;
  final String firstLabel;
  final String secondValue;
  final String secondLabel;
  final String cardColor;
  final bool isSingle;

  DiaryStatsItem({required this.id, required this.image, required this.title, required this.titleColor, required this.firstValue, required this.firstLabel, required this.secondValue, required this.secondLabel, required this.cardColor, required this.isSingle});
}
