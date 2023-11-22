import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:millionaire/logic/api.dart';
import 'package:millionaire/provider.dart';

import 'question_page.dart';
import 'start_page.dart';

class MoneyPage extends ConsumerWidget {
  const MoneyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [HexColor('010044'), Colors.black])),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 2),
          child: ListView(
            children: [
              MoneyTreeLevel(
                questionIndex: 15,
                questionValue: '1 MILLION',
              ),
              MoneyTreeLevel(
                questionIndex: 14,
                questionValue: '500,000',
              ),
              MoneyTreeLevel(
                questionIndex: 13,
                questionValue: '250,000',
              ),
              MoneyTreeLevel(
                questionIndex: 12,
                questionValue: '125,000',
              ),
              MoneyTreeLevel(
                questionIndex: 11,
                questionValue: '64,000',
              ),
              MoneyTreeLevel(
                questionIndex: 10,
                questionValue: '32,000',
              ),
              MoneyTreeLevel(
                questionIndex: 9,
                questionValue: '16,000',
              ),
              MoneyTreeLevel(
                questionIndex: 8,
                questionValue: '8,000',
              ),
              MoneyTreeLevel(
                questionIndex: 7,
                questionValue: '4,000',
              ),
              MoneyTreeLevel(
                questionIndex: 6,
                questionValue: '2,000',
              ),
              MoneyTreeLevel(
                questionIndex: 5,
                questionValue: '1,000',
              ),
              MoneyTreeLevel(
                questionIndex: 4,
                questionValue: '500',
              ),
              MoneyTreeLevel(
                questionIndex: 3,
                questionValue: '300',
              ),
              MoneyTreeLevel(
                questionIndex: 2,
                questionValue: '200',
              ),
              MoneyTreeLevel(
                questionIndex: 1,
                questionValue: '100',
              ),
              MillionaireButton(
                text: 'Question Page',
                fontSize: 24,
                onPressed: () {
                  addQuestionToState(ref);
                  Future.delayed(3.seconds).then((value) => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const QuestionPage()),
                      ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MoneyTreeLevel extends ConsumerWidget {
  final int questionIndex;
  final String questionValue;

  const MoneyTreeLevel(
      {super.key, required this.questionIndex, required this.questionValue});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: ref.watch(questionIndexProvider) + 1 == questionIndex
          ? Colors.amber.withOpacity(.25)
          : null,
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Row(
          children: [
            Text(
              questionIndex > 9 ? questionIndex.toString() : '  $questionIndex',
              style: TextStyle(
                  color: questionIndex % 5 == 0
                      ? Colors.amber.shade100
                      : Colors.amber.shade600,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              width: 24,
            ),
            Text(
              '\$$questionValue',
              style: TextStyle(
                  color: questionIndex % 5 == 0
                      ? Colors.amber.shade100
                      : Colors.amber.shade600,
                  letterSpacing: 3,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            )
          ],
        ),
      ),
    );
  }
}
