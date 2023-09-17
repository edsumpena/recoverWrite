import 'dart:io';

import 'package:flutter/material.dart';
import 'package:recovery_app/Login.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'BuildPage.dart';

// https://flutterawesome.com/onboarding-screen-ui-or-introduction-screen-in-flutter-sign-in-and-sign-up/

class Onboarding extends StatefulWidget{
  @override
  State <StatefulWidget> createState () => _OnboardingState();
}

class _OnboardingState extends State<Onboarding>{

  String urlImage = '';
  String title = '';
  String subtitle = '';
  final controller = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: height * 0.085),
        child: PageView(
          controller: controller,
          onPageChanged: (index){
            setState(() => isLastPage = index == 2);
          },
          children: const [

            BuildPage(
              urlImage: 'assets/images/record.png',
              title: '1. Record',
              subtitle: 'Log your daily thoughts and symptoms with toggles and journal entries.',
            ),

            BuildPage(
              urlImage: 'assets/images/reflect.png',
              title: '2. Reflect',
              subtitle: 'Send your log to your healthcare provider and review your analysis over time ',
            ),

            BuildPage(
              urlImage: 'assets/images/recover.png',
              title: '3. Recover',
              subtitle: 'Build your relationship with your healthcare provider and focus on your journey',
            ),

          ],
        ),
      ),

      bottomSheet: isLastPage
          ? TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xff4e1dc2),
          minimumSize: Size.fromHeight(height * 0.075),
        ),
        onPressed: () async{
          //navigate to choose page
          /*final prefs = await SharedPreferences.getInstance();
          prefs.setBool('showChoose', true);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Choose()),
          );*/

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Login()),
          );
        },
        child: const Text(
          'Get Started',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      )
          :Container(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        height: height * 0.085,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            //skip
            TextButton(
                onPressed: () => controller.jumpToPage(2),
                child: const Text('SKIP',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff4e1dc2),
                  ),
                )),
            //dots
            Center(
              child: SmoothPageIndicator(
                controller: controller,
                count: 3,
                effect: WormEffect(
                  spacing: width * 0.05,
                  dotColor: Colors.black26,
                  activeDotColor: const Color(0xff4e1dc2),
                ),
                //to click on dots and move
                onDotClicked: (index) => controller.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease,
                ),
              ),
            ),
            //next
            TextButton(
                onPressed: () => controller.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease,),
                child: const Text('NEXT',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff4e1dc2),
                  ),)),
          ],
        ),
      ),
    );
  }
}