import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:millionaire/models/question.dart';
import 'package:millionaire/pages/money_page.dart';
import 'package:millionaire/pages/start_page.dart';
import 'package:millionaire/pages/winning_page.dart';
import 'package:millionaire/provider.dart';

import '../models/answer.dart';

class QuestionPage extends ConsumerWidget {
  const QuestionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var questionObject =
        ref.watch(questionListProvider)[ref.watch(questionIndexProvider)];
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
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
                      SizedBox(
                          height: 175,
                          child: Image.asset(ref.watch(movingRegisProvider)
                              ? 'assets/regis.gif'
                              : 'assets/still_regis.png')),
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
                      ]
                          .animate(interval: 650.ms, delay: 2500.ms)
                          .slideX()
                          .fadeIn(),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: Colors.transparent,
                      contentPadding: EdgeInsets.zero,
                      content: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                            color: HexColor('010044'),
                            border: Border.all(color: Colors.white, width: 3),
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Quit Game?',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  MillionaireButton(
                                      buttonWidth: 150,
                                      buttonHexStringColor: 'CC9744',
                                      text: 'Quit',
                                      onPressed: () async {
                                        ref
                                            .read(
                                                questionIndexProvider.notifier)
                                            .state = 0;
                                        Navigator.popUntil(
                                            context, (route) => route.isFirst);
                                        var player =
                                            ref.watch(gameSoundProvider);
                                        await player.stop();
                                        await player.setAsset(
                                            'assets/trap_millionaire.mp3');
                                        await player.play();
                                      })
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.close,
                  size: 48,
                  color: Colors.red.withOpacity(.50),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MillionaireAnswerButton extends HookConsumerWidget {
  final Answer answer;

  const MillionaireAnswerButton({super.key, required this.answer});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var _clicked = useState(false);

    return MillionaireButton(
        buttonHexStringColor: _clicked.value ? '09A655' : '010044',
        buttonWidth: 300,
        fontSize: 18,
        text: answer.answerText,
        onPressed: () async {
          var player = ref.watch(gameSoundProvider);
          var effectPlayer = ref.watch(gameSoundEffectProvider);
          _clicked.value = true;
          ref.read(movingRegisProvider.notifier).state = false;
          await player.stop();

          Future.delayed(2500.ms).then((value) async {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: Colors.transparent,
                    contentPadding: EdgeInsets.zero,
                    content: AnswerModal(
                      correct: answer.isCorrect,
                    ),
                  );
                });
            if (answer.isCorrect) {
              await effectPlayer.setAsset('assets/correct.mp3');
              await effectPlayer.play();
            } else {
              await effectPlayer.setAsset('assets/incorrect.mp3');
              await effectPlayer.play();
            }
          });
        });
  }
}

class AnswerModal extends ConsumerWidget {
  final bool correct;
  const AnswerModal({super.key, required this.correct});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                onPressed: () async {
                  var player = ref.watch(gameSoundProvider);
                  if (correct) {
                    if (ref.watch(questionIndexProvider) > 14) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WinningPage()),
                      );
                      await player.stop();
                      await player.setAsset('assets/trap_millionaire.mp3');
                      await player.play();
                    }
                    await player.stop().then(
                      (value) {
                        Future.delayed(4000.ms).then((value) => player.play());
                      },
                    );
                    ref.read(questionIndexProvider.notifier).state =
                        ref.read(questionIndexProvider) + 1;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MoneyPage()),
                    );
                  } else {
                    ref.read(questionIndexProvider.notifier).state = 0;
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    await player.stop();
                    await player.setAsset('assets/trap_millionaire.mp3');
                    await player.play();
                  }
                },
              ),
            )
          ],
        ),
      ),
    ).animate(delay: 500.ms).fadeIn(duration: 800.ms);
  }
}
