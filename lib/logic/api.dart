import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:millionaire/models/answer.dart';
import 'dart:convert';
import '../models/question.dart';
import '../provider.dart';
import 'difficulty.dart';

Future<Question> getQuestion(String difficulty) async {
  final dio = Dio();
  var unescape = HtmlUnescape();
  Response response;
  response = await dio.get(
      'https://opentdb.com/api.php?amount=1&difficulty=$difficulty&type=multiple');

  List<dynamic> questionsRaw = response.data['results'] as List;

  Question retrievedQuestion = Question(questionText: '', answers: []);

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
    retrievedQuestion = Question(questionText: questionText, answers: answers);
  }

  return retrievedQuestion;
}

addQuestionToState(WidgetRef ref) async {
  var index = ref.watch(questionIndexProvider);
  if (index < 6) {
    ref.read(questionProvider.notifier).state =
        await getQuestion(Difficulty.easy.name);
  } else if (index > 5 && index < 11) {
    ref.read(questionProvider.notifier).state =
        await getQuestion(Difficulty.easy.name);
  } else {
    ref.read(questionProvider.notifier).state =
        await getQuestion(Difficulty.easy.name);
  }
}
