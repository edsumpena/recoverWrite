import 'package:flutter/material.dart';
import 'package:recovery_app/SelectType.dart';
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
              urlImage: 'assets/images/placeholder.png',
              title: 'Cool',
              subtitle: 'ajvneifiefefei bidnidnbrbvinvdnve ifiefbeife nciwnbfiwbwb wnbciwbcxmcnx',
            ),

            BuildPage(
              urlImage: 'assets/images/placeholder.png',
              title: 'Cool 2',
              subtitle: 'ajvneifiefefeib idnidnbrbvinvdnve ifiefbeife nciwnbfiwbwb wnbciwbcxmcnx',
            ),

            BuildPage(

              urlImage: 'assets/images/placeholder.png',
              title: 'Cool 3',
              subtitle: 'ajvneifie fefeibidnid nbrbvinvdnve ifiefbeife nciwnbfiwbwb wnbciwbcxmcnx',
            ),

          ],
        ),
      ),

      bottomSheet: isLastPage
          ? TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.indigoAccent,
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
            MaterialPageRoute(builder: (context) => SelectType()),
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
                child: const Text('SKIP', style: TextStyle(fontSize: 17,),)),
            //dots
            Center(
              child: SmoothPageIndicator(
                controller: controller,
                count: 3,
                effect: WormEffect(
                  spacing: width * 0.05,
                  dotColor: Colors.black26,
                  activeDotColor: Colors.indigoAccent,
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
                child: const Text('NEXT', style: TextStyle(fontSize: 17,),)),
          ],
        ),
      ),
    );
  }
}