import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:millionaire/content/dollar_amounts.dart';
import 'package:millionaire/pages/question_page.dart';
import 'package:millionaire/provider.dart';

class MoneyPage extends HookConsumerWidget {
  const MoneyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var moneyIndex = ref.watch(questionIndexProvider);

    useEffect(() {
      Future.delayed(4000.ms, () {
        ref.read(movingRegisProvider.notifier).state = true;
        if (ref.watch(firstNavProvider)) {
          Navigator.pop(context);
        }
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const QuestionPage()),
        );
        ref.read(firstNavProvider.notifier).state = true;
      });
    }, []);

    return Scaffold(
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
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Row(
                  children: [
                    SizedBox(
                        height: 120,
                        width: 120,
                        child: Image.asset('assets/regis.gif')),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'The ${moneyIndex == 0 ? 'first' : 'next'} question, for \$${dollarAmounts[moneyIndex]}',
                            softWrap: true,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ).animate().slideY(begin: -0.5, duration: 500.ms).fadeIn(),
              ),
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
