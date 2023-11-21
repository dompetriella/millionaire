import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:millionaire/pages/start_page.dart';

class QuestionPage extends ConsumerWidget {
  const QuestionPage({super.key});

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              child: Text(
                'QUESTION',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            Center(
              child: Column(
                children: [
                  MillionaireButton(text: 'Answer 1', onPressed: () {}),
                  SizedBox(
                    height: 5,
                  ),
                  MillionaireButton(text: 'Answer 2', onPressed: () {}),
                  SizedBox(
                    height: 5,
                  ),
                  MillionaireButton(text: 'Answer 3', onPressed: () {}),
                  SizedBox(
                    height: 5,
                  ),
                  MillionaireButton(text: 'Answer 4', onPressed: () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
