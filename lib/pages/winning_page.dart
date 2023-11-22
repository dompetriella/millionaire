import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:millionaire/pages/start_page.dart';
import 'package:millionaire/provider.dart';

class WinningPage extends ConsumerWidget {
  const WinningPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [HexColor('010044'), Colors.black])),
          child: Stack(
            children: [
              Center(
                  child: Transform.scale(
                      scale: 4, child: Image.asset('assets/cash_rain.gif'))),
              Center(
                child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "YOU'RE A MILLIONAIRE!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w900,
                              color: Colors.white),
                        )
                            .animate(
                              onPlay: (controller) => controller.repeat(),
                            )
                            .tint(duration: 400.ms, color: Colors.green)
                            .scale(duration: 600.ms, begin: Offset(1.2, 1.2)),
                        Text(
                          '(The prize is bragging rights, sorry)',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    )),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: MillionaireButton(
                      text: 'Play Again',
                      onPressed: () {
                        ref.read(questionIndexProvider.notifier).state = 0;
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
