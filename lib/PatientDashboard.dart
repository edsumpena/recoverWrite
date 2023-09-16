import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:recovery_app/entry.dart';

import 'bouncing.dart';
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
          backgroundColor: Colors.grey.shade300,
          floatingActionButton: SpeedDial(
            animatedIcon: AnimatedIcons.menu_close,
            animatedIconTheme: const IconThemeData(size: 26),
            backgroundColor: Colors.indigo,
            visible: true,
            curve: Curves.bounceIn,
            elevation: 15,
            overlayOpacity: 0.5,
            children: [
              SpeedDialChild(
                  child: const Icon(Icons.list_alt,
                      color: Colors.white),
                  backgroundColor: Colors.indigoAccent,
                  onTap: () {
                  },
                  label: 'Entry List',
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: width * 0.0125 + 11),
                  labelBackgroundColor: Colors.indigoAccent),
              SpeedDialChild(
                  child: const Icon(Icons.add,
                      color: Colors.white),
                  backgroundColor: Colors.indigoAccent,
                  onTap: () {
                  },
                  label: 'Add Journal Entry',
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: width * 0.0125 + 11),
                  labelBackgroundColor: Colors.indigoAccent),
            ],
          ),
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
                            child: Column(children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 16, right: 16, top: height * 0.1),
                                child: Text("Hi John!",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: width * 0.10,
                                    )),
                              ),
                    Padding(
                        padding: EdgeInsets.only(
                            left: width * 0.075, right: width * 0.075, top: height * 0.035),
                        child: Bouncing(
                            enlarge: true,
                            onPress: () {},
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(27.0),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.15),
                                        offset: const Offset(2, 0),
                                        spreadRadius: 1,
                                        blurRadius: 25,
                                      ),
                                    ]),
                                child: Container(
                                    margin: EdgeInsets.only(
                                        top: height * 0.025,
                                        left: width * 0.05,
                                        right: width * 0.05,
                                        bottom: height * 0.025),
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          RichText(
                                              maxLines: 2,
                                              textAlign: TextAlign.center,
                                              text: TextSpan(children: [
                                                TextSpan(
                                                    text:
                                                    "Days on Regiment:\n",
                                                    style: TextStyle(
                                                      fontSize: width * 0.06,
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w600,
                                                    )),
                                                TextSpan(
                                                    text: "5",
                                                    style: TextStyle(
                                                        fontSize: width * 0.15,
                                                        color: Colors.black))
                                              ])),
                                        ])))),
                    ),
                            ]),),
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
        SizedBox(height: height * 0.02),
        Padding(
          padding: EdgeInsets.only(bottom: height * 0.02, top: height * 0.0275),
          child: Align(alignment: Alignment.center, child: Entry()
              ),
        ),
        SizedBox(height: height * 0.02),
        Bouncing(
            enlarge: true,
            onPress: () {},
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(27.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        offset: const Offset(2, 0),
                        spreadRadius: 1,
                        blurRadius: 25,
                      ),
                    ]),
                child: Container(
                    margin: EdgeInsets.only(
                        top: height * 0.025,
                        left: width * 0.09,
                        right: width * 0.09,
                        bottom: height * 0.025),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          RichText(
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              text: TextSpan(children: [
                                TextSpan(
                                    text:
                                    "Assigned by:\n",
                                    style: TextStyle(
                                      fontSize: width * 0.04,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    )),
                                TextSpan(
                                    text: "Dr. House M.D.",
                                    style: TextStyle(
                                        fontSize: width * 0.09,
                                        color: Colors.black))
                              ])),
                        ])))),
        SizedBox(height: height * 0.04),
      ]),
    );
  }
}

/*Container(
      // Blog showcase part, will be interactive
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: <Widget>[*/
