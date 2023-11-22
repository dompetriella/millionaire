import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models/question.dart';

final questionIndexProvider = StateProvider<int>((ref) {
  return 0;
});

final questionProvider =
    StateProvider<Question>((ref) => Question(questionText: '', answers: []));
