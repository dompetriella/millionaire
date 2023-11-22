import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:millionaire/logic/api.dart';
import 'package:millionaire/pages/money_page.dart';

class StartPage extends ConsumerWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int count = 0;

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [HexColor('010044'), Colors.black])),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Stack(
              children: [
                Container(
                  width: 270,
                  height: 270,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/title_icon.png'),
                  ),
                ),
              ],
            ),
          ),
          MillionaireButton(
            text: 'Start',
            fontSize: 24,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MoneyPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class MillionaireButton extends StatelessWidget {
  final String text;
  final double buttonWidth;
  final double buttonHeight;
  final double fontSize;
  final String buttonHexStringColor;
  final VoidCallback onPressed;

  const MillionaireButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.buttonHexStringColor = '010044',
    this.buttonWidth = 250,
    this.buttonHeight = 60,
    this.fontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: HexColor(buttonHexStringColor),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: Colors.white, width: 2)),
          fixedSize: Size(buttonWidth, buttonHeight),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: fontSize, color: Colors.white),
        ));
  }
}
