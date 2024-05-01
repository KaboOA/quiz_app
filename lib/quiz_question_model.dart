class QuizQuestionModel {
  String title;
  String? imgUrl;
  List<String> options;
  int ansIdx;

  QuizQuestionModel({
    required this.title,
    required this.options,
    this.imgUrl,
    required this.ansIdx,
  });

  factory QuizQuestionModel.fromJson(Map<String, dynamic> json) {
    return QuizQuestionModel(
      title: json['title'] as String,
      imgUrl: json['imgUrl'] as String?,
      options: List<String>.from(json['options'] as List<dynamic>),
      ansIdx: json['ansIdx'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'imgUrl': imgUrl,
      'options': options,
      'ansIdx': ansIdx,
    };
  }
}
