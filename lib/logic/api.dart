import 'package:dio/dio.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
      'https://opentdb.com/api.php?amount=5&category=9&difficulty=easy&type=multiple');

  List<dynamic> questionsRaw = response.data['results'] as List;

  List<Question> modifiedQuestions = [];

  for (var question in questionsRaw) {
    // get answers from JSON, make them object, put them all in a list, shuffle
    List<Answer> answers = [];
    for (var answerText in question['incorrect_answers']) {
      answers.add(
          Answer(answerText: unescape.convert(answerText), isCorrect: false));
    }
    answers
        .add(Answer(answerText: question['correct_answer'], isCorrect: true));
    answers.shuffle();
    // use the unescape library to clean the text from the JSON of html unwanteds
    var questionText = unescape.convert(question['question']);

    modifiedQuestions
        .add((Question(questionText: questionText, answers: answers)));
  }

  return modifiedQuestions;
}

Future<void> prepareQuestionsForState(WidgetRef ref) async {
  List<Question> easyQuestions = await getQuestions(Difficulty.easy.name);
  ref.read(questionListProvider.notifier).addQuestions(easyQuestions);

  Future.delayed(5.seconds).then((value) async {
    List<Question> mediumQuestions = await getQuestions(Difficulty.medium.name);
    ref.read(questionListProvider.notifier).addQuestions(mediumQuestions);

    Future.delayed(5.seconds).then((value) async {
      List<Question> hardQuestions = await getQuestions(Difficulty.hard.name);
      ref.read(questionListProvider.notifier).addQuestions(hardQuestions);
    });
  });
}
