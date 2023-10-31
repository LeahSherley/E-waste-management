import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:quiz_app/myWidgets.dart';
import 'package:quiz_app/pages/login.dart';

// ignore: must_be_immutable
class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  PageDecoration getdecoration = const PageDecoration(
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Colors.blueGrey,
          
        ),
        bodyTextStyle: TextStyle(
          fontSize: 12.5,
          color: Colors.grey,
          
        ),
        imagePadding: EdgeInsets.all(30),
        bodyPadding: EdgeInsets.all(10),
      );
  DotsDecorator dotsDecorator =  DotsDecorator(
    size: const Size.square(10.0),
    activeSize: const Size(10.0, 10.0),
    spacing: const EdgeInsets.symmetric(horizontal: 3.0),
    activeShape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
  );
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: IntroductionScreen(
        globalBackgroundColor: Colors.grey[100],
          animationDuration: 600,
          pages: [
            PageViewModel(
              title: "Safe Disposal",
              body:
                  "Know where to dispose off your Electronic Waste by disposing it safely and safeguarding the environment.",
              image: Image.asset(
                "assets/images/photo2.jpg",
                width: 350,
              ),
              decoration: getdecoration,
            ),
            PageViewModel(
              title: "Efficient Collection",
              body:
                  "Schedule Electronic Waste pick-ups at your Convenience for Collection.",
              image: Image.asset("assets/images/truck.png"),
              decoration: getdecoration,
            ),
            PageViewModel(
              title: "Sustainable Recycling",
              body:
                  "Safeguarding human and environmental health by keeping electronic trash out of landfills through recycling.",
              image: Image.asset("assets/images/photo1-removebg-preview (1).png"),
              decoration: getdecoration,
            ),
          ],
          showSkipButton: true,
          showDoneButton: true,
          showNextButton: true,
          done: mytext("Start!"),
          skip: mytext("Skip"),
          next: const Icon(
            Icons.east_rounded,
            color: Colors.grey,
            size: 17,
          ),
          onDone: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const Login()));
          },
          dotsDecorator: dotsDecorator,
          baseBtnStyle: TextButton.styleFrom(
            backgroundColor: Colors.blueGrey,
          ),
          skipStyle: TextButton.styleFrom(foregroundColor: Colors.grey)),
    );
  }

  
}
