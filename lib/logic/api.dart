import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import '../models/question.dart';
import '../provider.dart';
import 'difficulty.dart';

getQuestionsVoid(String difficulty) async {
  final dio = Dio();
  Response response;
  response = await dio.get(
      'https://opentdb.com/api.php?amount=2&difficulty=$difficulty&type=multiple');

  List<dynamic> questions = response.data['results'] as List;

  print(questions);
}

// Future<List<Question>> getQuestions(String difficulty) async {
//   final dio = Dio();
//   Response response;
//   response = await dio.get(
//       'https://opentdb.com/api.php?amount=5&difficulty=$difficulty&type=multiple');

//   Map<String, dynamic> questions = response.data['results'];
// }

// String decode(String html) => htmlEscape.convert(html);

// addQuestionsToState(WidgetRef ref) async {
//   List<Question> easyQuestions = await getQuestions(Difficulty.easy.name);
//   List<Question> mediumQuestions = await getQuestions(Difficulty.medium.name);
//   List<Question> hardQuestions = await getQuestions(Difficulty.hard.name);
//   easyQuestions.shuffle();
//   mediumQuestions.shuffle();
//   hardQuestions.shuffle();
//   List<Question> questions = easyQuestions + mediumQuestions + hardQuestions;
//   ref.read(questionsProvider.notifier).state = questions;
// }
