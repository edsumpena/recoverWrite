import 'package:flutter/material.dart';
import 'package:recovery_app/PatientDashboard.dart';
import 'package:recovery_app/ProviderDashboard.dart';

import 'bouncing.dart';
import 'fade_animations.dart';

class SelectType extends StatefulWidget {
  const SelectType({super.key});

  @override
  State<SelectType> createState() => _SelectTypeState();
}

class _SelectTypeState extends State<SelectType> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
          backgroundColor: Colors.white, body: _buildUserType(context)),
    );
  }

  Widget _buildUserType(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Center(
        child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    offset: const Offset(2, 0),
                    spreadRadius: 1,
                    blurRadius: 25,
                  ),
                ]),
            margin: EdgeInsets.symmetric(vertical: height * 0.3),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'I am a...',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: width * 0.1,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    FadeAnimation(
                      1,
                        Bouncing(
                          onPress: () {},
                          child: SizedBox.fromSize(
                        size: Size(width * 0.4, width * 0.4),
                        child: ClipOval(
                          child: Material(
                            color: Colors.indigoAccent,
                            child: InkWell(
                              splashColor: Colors.indigo,
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => ProviderDashboard()),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    "assets/images/provider.png",
                                    width: width * 0.15,
                                    height: width * 0.15,
                                  ),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  Text(
                                    "Healthcare Provider",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: width * 0.05,
                                      fontFamily: 'Poppins',
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                          ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.1,
                    ),
                    FadeAnimation(
                      1,
                        Bouncing(
                          onPress: () {},
                          child: SizedBox.fromSize(
                        size: Size(width * 0.4, width * 0.4),
                        child: ClipOval(
                          child: Material(
                            color: Colors.indigoAccent,
                            child: InkWell(
                              splashColor: Colors.indigo,
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => PatientDashboard()),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    "assets/images/patient.png",
                                    width: width * 0.15,
                                    height: width * 0.15,
                                  ),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  Text(
                                    "Patient",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: width * 0.05,
                                      fontFamily: 'Poppins',
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                        ),
                    )
                  ])
                ])));
  }
}
