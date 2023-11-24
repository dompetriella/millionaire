import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:millionaire/logic/api.dart';
import 'package:millionaire/pages/money_page.dart';
import 'package:millionaire/provider.dart';

class StartPage extends HookConsumerWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initFunction = useCallback((_) async {
      final player = AudioPlayer();
      await player.setAsset('assets/trap_millionaire.mp3');
      await player.setLoopMode(LoopMode.all);
      await player.setVolume(0);
      ref.read(gameSoundProvider.notifier).state = player;
    }, []);

    useEffect(() {
      initFunction(null);
      return null;
    }, []);
    return Stack(
      children: [
        Container(
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
                fontSize: 28,
                buttonHeight: 75,
                buttonWidth: 260,
                onPressed: () {
                  ref.read(questionListProvider.notifier).clear();
                  prepareQuestionsForState(ref);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MoneyPage()),
                  );
                },
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () async {
            var player = ref.watch(gameSoundProvider);
            if (player.playing) {
              await player.setVolume(0);
              ref.watch(muteProvider.notifier).state = true;
            } else {
              await player.setVolume(1);
              if (!ref.watch(gameSoundProvider).playing) {
                await player.play();
              }
              ref.watch(muteProvider.notifier).state = false;
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Icon(
                ref.watch(muteProvider) ? Icons.volume_off : Icons.volume_up,
                size: 64,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
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
