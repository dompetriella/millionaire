import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

import 'models/question.dart';

final questionIndexProvider = StateProvider<int>((ref) {
  return 0;
});

final firstNavProvider = StateProvider<bool>((ref) => false);

final movingRegisProvider = StateProvider<bool>((ref) => true);

final gameSoundProvider = StateProvider<AudioPlayer>((ref) {
  return AudioPlayer();
});

final muteProvider = StateProvider<bool>((ref) => true);

final gameSoundEffectProvider = StateProvider<AudioPlayer>((ref) {
  return AudioPlayer();
});

// Create a class that extends StateNotifier to manage the state
class QuestionListNotifier extends StateNotifier<List<Question>> {
  // Initialize the state with an empty list
  QuestionListNotifier() : super([]);

  // Method to add a question to the list
  void addQuestion(Question question) {
    state = [...state, question];
  }

  void addQuestions(List<Question> newQuestions) {
    state = [...state, ...newQuestions];
  }

  void clear() {
    state = [];
  }
}

// Create a StateNotifierProvider for the QuestionListNotifier
final questionListProvider =
    StateNotifierProvider<QuestionListNotifier, List<Question>>(
  (ref) => QuestionListNotifier(),
);
