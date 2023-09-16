import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:recovery_app/entry.dart';
import 'package:recovery_app/journal_form.dart';

import 'bouncing.dart';
import 'fade_animations.dart';
import 'package:fl_chart/fl_chart.dart'; // for the analysis chart

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
          appBar: AppBar(
              elevation: 0.0,
              backgroundColor: const Color(0xff4e1dc2),
              //backgroundColor: Colors.indigo,
              leading: IconButton(
                icon: Platform.isAndroid
                    ? const Icon(Icons.arrow_back, color: Colors.white)
                    : const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed:  () => Navigator.of(context).pop(),
              )
          ),
          backgroundColor: Colors.grey.shade300,
          floatingActionButton: SpeedDial(
            animatedIcon: AnimatedIcons.menu_close,
            animatedIconTheme: const IconThemeData(size: 26),
            backgroundColor: const Color(0xff4e1dc2),
            visible: true,
            curve: Curves.bounceIn,
            elevation: 15,
            overlayOpacity: 0.5,
            children: [
              SpeedDialChild(
                  child: const Icon(Icons.list_alt,
                      color: Colors.white),
                  backgroundColor: const Color (0xff876EC2),
                  onTap: () {
                  },
                  label: 'View Entry List',
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: width * 0.0125 + 11),
                  labelBackgroundColor: const Color (0xff876EC2)),
              SpeedDialChild(
                  child: const Icon(Icons.add,
                      color: Colors.white),
                  backgroundColor: const Color (0xffaa9fc2),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AddEntry()),
                    );
                  },
                  label: 'Add Journal Entry',
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: width * 0.0125 + 11),
                  labelBackgroundColor: const Color (0xffaa9fc2)),
              ],
          ),
          body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: height * 0.325,
                    decoration: const BoxDecoration(
                      color: const Color(0xff4e1dc2),
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
                                    left: 16, right: 16, top: height * 0.02),
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
          padding: EdgeInsets.only(bottom: height * 0.02, top: height * 0.0275, left: width * 0.04, right: width * 0.04 ),
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
        _buildPatientAnalysis(context),
        SizedBox(height: height * 0.04),
      ]),
    );
  }
}

Widget _buildPatientAnalysis(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;

  return SizedBox(
    width: 300,
    height: 300,
    //return our analysis line chart
    child: LineChart(
      LineChartData(
        // read about it in the LineChartData section
          lineBarsData: [
            //only using one line
            LineChartBarData(
                show: true,
                spots: [
                  const FlSpot(0, 1),
                  const FlSpot(1, 0.5),
                ],
                color: const Color(0xff4e1dc2),
                barWidth: 2.0, //may need to change size
                isCurved: true,
                isStrokeCapRound: true,
                dotData: FlDotData(
                    show: true
                )
            )
          ],
          titlesData: FlTitlesData(
              show: true,
              leftTitles: AxisTitles(
                  axisNameWidget: const Text("Sentiment Analysis")
              ),
              bottomTitles: AxisTitles(
                  axisNameWidget: const Text("Date of Entry")
              )
          ),
          lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(
                tooltipBgColor: const Color(0xff876EC2),
              ),
              handleBuiltInTouches: true // may take out
          ),
          extraLinesData: ExtraLinesData(
            horizontalLines: [
            ],
            verticalLines: [
            ]
          ),
          minX: 0,
          maxX: 5,
          minY: 0,
          maxY: 1,
          clipData: FlClipData.none(),
          backgroundColor: const Color(0xffaa9fc2)
      ),
      swapAnimationDuration: Duration(milliseconds: 150), // Optional
      swapAnimationCurve: Curves.linear, // Optional
    )
  );
}

/*Container(
      // Blog showcase part, will be interactive
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: <Widget>[*/
