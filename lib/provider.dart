import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models/question.dart';

final moneyTreeIndexProvider = StateProvider<int>((ref) {
  return 1;
});

final questionsProvider = StateProvider<List<Question>>((ref) => []);
