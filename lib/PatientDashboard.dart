import 'package:flutter/material.dart';

import 'fade_animations.dart';

class PatientDashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PatientDashboardState();
}

class _PatientDashboardState extends State<PatientDashboard> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: height * 0.4,
                    decoration: const BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    //padding: const EdgeInsets.only(top: 5.0),
                    child: FadeAnimation(
                      2.0,
                      Stack(
                        children: [
                          Center(
                            child: Padding(
                              padding: EdgeInsets.only(left: 16, right: 16, top: height * 0.05),
                              child: Text("Hi John!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * 0.10,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  FadeAnimation(
                    2.0,
                    _buildPatientDashboard(context),
                  ),
                ],
              ))),
    );
  }

  Widget _buildPatientDashboard(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      // Blog showcase part, will be interactive
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(children: <Widget>[
        Padding(
          padding: EdgeInsets.only(bottom: height * 0.02, top: height * 0.0275),
          child: Align(
              alignment: Alignment.topLeft,
              child:
                  null /*Text(
              "Hi John!",
              style: TextStyle(
                color: Colors.indigoAccent,
                fontWeight: FontWeight.bold,
                fontSize: width * 0.015 + 15.5,
              ),
            ),*/
              ),
        ),
      ]),
    );
  }
}

/*Container(
      // Blog showcase part, will be interactive
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: <Widget>[*/
