import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:millionaire/models/question.dart';
import 'package:millionaire/pages/start_page.dart';
import 'package:millionaire/provider.dart';

import '../models/answer.dart';

class QuestionPage extends ConsumerWidget {
  const QuestionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var questionObject = ref.watch(questionProvider);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [HexColor('010044'), Colors.black])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                SizedBox(height: 175, child: Image.asset('assets/regis.gif')),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    child: Text(
                      questionObject.questionText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: Column(
                children: [
                  MillionaireAnswerButton(
                    answer: questionObject.answers[0],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  MillionaireAnswerButton(
                    answer: questionObject.answers[1],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  MillionaireAnswerButton(
                    answer: questionObject.answers[2],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  MillionaireAnswerButton(
                    answer: questionObject.answers[3],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MillionaireAnswerButton extends StatelessWidget {
  final Answer answer;
  const MillionaireAnswerButton({super.key, required this.answer});

  @override
  Widget build(BuildContext context) {
    return MillionaireButton(
        buttonWidth: 300,
        fontSize: 18,
        text: answer.answerText,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  contentPadding: EdgeInsets.zero,
                  content: AnswerModal(
                    correct: answer.isCorrect,
                  ),
                );
              });
        });
  }
}

class AnswerModal extends StatelessWidget {
  final bool correct;
  const AnswerModal({super.key, required this.correct});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
          color: HexColor('010044'),
          border: Border.all(color: Colors.white, width: 3),
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              correct ? 'Correct!' : 'Incorrect',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: correct ? Colors.white : Colors.red,
                fontSize: 48,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: MillionaireButton(
                text: correct ? 'Continue' : 'Game Over',
                buttonWidth: 170,
                fontSize: 20,
                buttonHexStringColor: correct ? '09A655' : 'CC9744',
                onPressed: () {
                  // pop pop
                  if (correct) {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  } else {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
