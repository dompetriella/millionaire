import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:millionaire/models/answer.dart';
import 'dart:convert';
import '../models/question.dart';
import '../provider.dart';
import 'difficulty.dart';

Future<List<Question>> getQuestions(String difficulty) async {
  final dio = Dio();
  var unescape = HtmlUnescape();
  Response response;
  response = await dio.get(
      'https://opentdb.com/api.php?amount=2&difficulty=$difficulty&type=multiple');

  List<dynamic> questionsRaw = response.data['results'] as List;
  List<Question> questions = [];
  for (var question in questionsRaw) {
    // get answers from JSON, make them object, put them all in a list, shuffle
    List<Answer> answers = [];
    for (var answerText in question['incorrect_answers']) {
      answers.add(Answer(answerText: answerText, isCorrect: false));
    }
    answers
        .add(Answer(answerText: question['correct_answer'], isCorrect: true));
    answers.shuffle();
    // use the unescape library to clean the text from the JSON of html unwanteds
    var questionText = unescape.convert(question['question']);
    questions.add(Question(questionText: questionText, answers: answers));
  }

  return questions;
}

addQuestionsToState(WidgetRef ref) async {
  List<Question> easyQuestions = await getQuestions(Difficulty.easy.name);
  List<Question> mediumQuestions = await getQuestions(Difficulty.medium.name);
  List<Question> hardQuestions = await getQuestions(Difficulty.hard.name);
  easyQuestions.shuffle();
  mediumQuestions.shuffle();
  hardQuestions.shuffle();
  List<Question> questions = easyQuestions + mediumQuestions + hardQuestions;
  ref.read(questionsProvider.notifier).state = questions;
}
