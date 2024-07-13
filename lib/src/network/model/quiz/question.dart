import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

@JsonSerializable(explicitToJson: true)
class MQuestion {
  String question;
  String id;
  String firstAnswer;
  String secondAnswer;
  String correctAnswer;

  MQuestion(
      {required this.question,
      required this.id,
      required this.firstAnswer,
      required this.secondAnswer,
      required this.correctAnswer});

  factory MQuestion.fromJson(Map<String, dynamic> json) =>
      _$MQuestionFromJson(json);

  Map<String, dynamic> toJson() => _$MQuestionToJson(this);

  @override
  String toString() {
    return 'MQuestion{question=$question, id=$id, firstAnswer=$firstAnswer, secondAnswer=$secondAnswer, correctAnswer=$correctAnswer}';
  }

  MQuestion copyWith(
      {String? question,
      String? id,
      String? firstAnswer,
      String? secondAnswer,
      String? correctAnswer}) {
    return MQuestion(
        question: question ?? this.question,
        id: id ?? this.id,
        firstAnswer: firstAnswer ?? this.firstAnswer,
        secondAnswer: secondAnswer ?? this.secondAnswer,
        correctAnswer: correctAnswer ?? this.correctAnswer);
  }
}
