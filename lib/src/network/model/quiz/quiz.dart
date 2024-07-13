import 'package:json_annotation/json_annotation.dart';

part 'quiz.g.dart';

@JsonSerializable(explicitToJson: true)
class MQuiz {
  MQuiz(
      {required this.title,
      required this.id,
      required this.detail,
      required this.numberQuestion});

  String title;
  String id;
  String detail;
  int numberQuestion;

  @override
  String toString() {
    return 'MQuiz{title=$title, id=$id, detail=$detail, numberQuestion=$numberQuestion}';
  }

  Map<String, dynamic> toJson() => _$MQuizToJson(this);

  factory MQuiz.fromJson(Map<String, dynamic> json) => _$MQuizFromJson(json);
  MQuiz copyWith(
      {String? title, String? id, String? detail, int? numberQuestion}) {
    return MQuiz(
        title: title ?? this.title,
        id: id ?? this.id,
        detail: detail ?? this.detail,
        numberQuestion: numberQuestion ?? this.numberQuestion);
  }
}
