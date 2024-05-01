class QuizQuestionModel {
  String title;
  String? imgUrl;
  List<Map<String, int>> options;
  QuizQuestionModel({
    required this.title,
    required this.options,
    this.imgUrl,
  });

  factory QuizQuestionModel.fromJson(Map<String, dynamic> json) {
    return QuizQuestionModel(
      title: json['title'] as String,
      imgUrl: json['imgUrl'] as String?,
      options: (json['options'] as List<dynamic>)
          .map((option) => option as Map<String, int>)
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'imgUrl': imgUrl,
      'options': options,
    };
  }
}
