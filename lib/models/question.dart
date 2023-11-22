import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:millionaire/models/answer.dart';

part 'question.freezed.dart';
part 'question.g.dart';

@freezed
class Question with _$Question {
  const factory Question(
      {@JsonKey(name: 'question') required String questionText,
      @JsonKey(name: 'category') required String category,
      @JsonKey(name: 'difficulty') required String difficulty,
      @JsonKey(name: 'correct_answer') required String correctAnswer,
      @JsonKey(name: 'incorrect_answers')
      required List<String> incorrectAnswers}) = _Question;

  factory Question.fromJson(Map<String, Object?> json) =>
      _$QuestionFromJson(json);
}
