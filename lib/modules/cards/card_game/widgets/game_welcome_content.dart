import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/constants.dart';
//import 'package:flutter/gestures.dart';
class GameWelcomeContent extends StatelessWidget {
  const GameWelcomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 35, right: 35, top: 20, bottom: 30),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              const SizedBox(height: 20),
              _imageWelcome(),
              const SizedBox(height: 30),
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    const TextSpan(text: 'At '),
                    TextSpan(
                      text: _paragraphBoldText, 
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor
                      ),
                    ),
                    TextSpan(text: _paragraph1),
                  ]
                ),
              ),
              const SizedBox(height: 20),
              Text(_paragraph2, style: const TextStyle(fontWeight: FontWeight.w500)),
              const SizedBox(
                height: 20,
              ),
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                      text: _paragraphBoldText, 
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                      ),
                      /* recognizer: TapGestureRecognizer()
                        ..onTap = () {
                        Navigator.pushNamed(context, 'game_screen');
                      }, */
                    ),
                    TextSpan(text: _paragraph3),
                  ]
                ),
              ),
              const SizedBox(height: 20.0),
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(text: _paragraph4),
                    TextSpan(
                      text: _paragraph4BoldText, 
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kSecondaryColor,
                      ),
                      /* recognizer: TapGestureRecognizer()
                        ..onTap = () {
                        Navigator.pushNamed(context, 'game_screen');
                      }, */
                    ),
                  ]
                ),
              ),
            ]
          
          ),
          Expanded(
            child: _buttonStartPlaying(context),
          )
          //const SizedBox(height: 40.0),
          //_buttonStartPlaying(context),
          //const SizedBox(height: 40.0),
        ],
      ),
    );
  }

  Widget _buttonStartPlaying(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //const SizedBox(width: 20),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                fixedSize: const Size(250, 45),
                //minimumSize: const Size(160, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                backgroundColor: kSecondaryColor,
              ),
              child: const Text(
                "Start playing now!",
                style: TextStyle(
                  fontSize: 16.0
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
            ),
          ),
        ),
        const SizedBox(width: 20),
      ],
    );
  }  

  Widget _imageWelcome() {
    return const Center(
      child: Image(
        image: AssetImage('assets/logos/game_play_learn.webp'),
      ),
    );
  }

  String get _paragraph1 {
    return " we focus on educating our users, consumers and clients, so that they make informed decisions when buying or selling a home.";
  }

  String get _paragraphBoldText {
    return "RHouze";
  }

  String get _paragraph2 {
    return "You can learn the market, while playing and having fun. You can guess what the SOLD price will be for any property. You may use all the info your consider from the listing and from our smartistics.";
  }

  String get _paragraph3 {
    return ' will keep track of your guessed SOLD price and those of any other users. We will tell you when the property is SOLD, and how close you were!';
  }

  String get _paragraph4 {
    return "You may be able to track your performance over time. Isn’t it fun? Its not only fun, it’s good for you to learn this market! - ";
  }

  String get _paragraph4BoldText {
    return "Try Now!";
  }
}
