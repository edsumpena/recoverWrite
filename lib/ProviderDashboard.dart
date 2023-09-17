import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recovery_app/entry.dart';

import 'bouncing.dart';
import 'fade_animations.dart';

import 'package:dart_sentiment/dart_sentiment.dart';
import 'package:collection/collection.dart';

class ProviderDashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProviderDashboardState();
}

class _ProviderDashboardState extends State<ProviderDashboard> {
  List<Map<String, dynamic>> entries = [];
  List<double> sentiment = [];

  int flagged_entry = -1;
  int sentiment_risk = 0;

  // Output is [-5, 5]
  // Threshold is based on | Score |
  double SENTIMENT_THRESHOLD_MEDIUM = 0.05;
  double SENTIMENT_THRESHOLD_HIGH = 0.1;

  @override
  void initState() {
    super.initState();

    _readEntries();
  }

  // Read entries and basic sentiment analysis
  Future<void> _readEntries() async {
    final dataDir = await getApplicationDocumentsDirectory();
    final sent_analyzer = Sentiment();

    while (true) {
      final dir = Directory('${dataDir.path}/Entries');

      await dir.create(recursive: true).then((value) async {
        if (dir.existsSync()) {
          List<FileSystemEntity> entities = await dir.list().toList();
          Iterable<File> files = entities.whereType<File>();

          List<Map<String, dynamic>> entries_tmp = [];
          List<double> sentiment_tmp = [];

          for (File f in files) {
            String entryJson = await f.readAsString();

            if (entryJson.isNotEmpty) {
              Map<String, dynamic> entry = json.decode(entryJson);
              double sent = 0.0;

              if (entry['journal']![0].isNotEmpty) {
                sent =
                    sent_analyzer.analysis(entry['journal']![0])['comparative'];
              }

              entries_tmp.add(entry);
              sentiment_tmp.add(sent);

              if (kDebugMode) {
                print(entry['journal']![0]);
                print(sent);
              }
            }
          }

          if (!const ListEquality().equals(entries_tmp, entries)) {
            int flagged_entry_tmp = -1;
            int sentiment_risk_tmp = 0;

            for (int i = 0; i < sentiment_tmp.length; i++) {
              if (sentiment_tmp[i].abs() >= SENTIMENT_THRESHOLD_MEDIUM) {
                flagged_entry_tmp = i;

                if (sentiment_tmp[i].abs() >= SENTIMENT_THRESHOLD_HIGH) {
                  sentiment_risk_tmp = 2;
                } else {
                  sentiment_risk_tmp = 1;
                }
              }
            }

            setState(() {
              flagged_entry = flagged_entry_tmp;
              entries = entries_tmp;
              sentiment = sentiment_tmp;
              sentiment_risk = sentiment_risk_tmp;
            });
          }
        }
      });

      await Future.delayed(const Duration(milliseconds: 3000));
    }
  }

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
              leading: IconButton(
                icon: Platform.isAndroid
                    ? const Icon(Icons.arrow_back, color: Colors.white)
                    : const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              )),
          backgroundColor: Colors.grey.shade300,
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
                                child: Text("Hi Dr. House M.D.!",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: width * 0.1,
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: width * 0.075,
                                    right: width * 0.075,
                                    top: height * 0.035),
                                child: Bouncing(
                                    enlarge: true,
                                    onPress: () {},
                                    child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(27.0),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.15),
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
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  RichText(
                                                      maxLines: 2,
                                                      textAlign:
                                                          TextAlign.center,
                                                      text: TextSpan(children: [
                                                        TextSpan(
                                                            text:
                                                                "Number of Patients:\n",
                                                            style: TextStyle(
                                                              fontSize:
                                                                  width * 0.06,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            )),
                                                        TextSpan(
                                                            text: "1",
                                                            style: TextStyle(
                                                                fontSize:
                                                                    width *
                                                                        0.15,
                                                                color: Colors
                                                                    .black))
                                                      ])),
                                                ])))),
                              ),
                            ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.04),
                  Visibility(
                    visible: flagged_entry >= 0,
                    child: Padding(
                        padding: EdgeInsets.only(
                            bottom: height * 0.02,
                            top: height * 0.0275,
                            left: width * 0.04,
                            right: width * 0.04),
                        child: FadeAnimation(
                            2.0,
                            Align(
                                alignment: Alignment.center,
                                child: Entry(
                                    entry: flagged_entry < 0
                                        ? null
                                        : entries[flagged_entry],
                                    sentiment_risk: flagged_entry < 0
                                        ? null
                                        : sentiment_risk)))),
                  ),
                  Visibility(
                    visible: flagged_entry >= 0,
                    child: SizedBox(height: height * 0.02),
                  ),
                  FadeAnimation(
                      2.0,
                      Bouncing(
                          onPress: () {}, child: _listOfPatients(context))),
                  SizedBox(height: height * 0.04),
                ],
              ))),
    );
  }

  Widget _listOfPatients(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return ListView.builder(
      itemBuilder: (BuildContext context, index) {
        return Card(
          child: InkWell(
            onTap: () {},
            child: ListTile(
              leading: const Icon(
                Icons.person,
                size: 36,
              ),
              contentPadding: EdgeInsets.only(
                  top: height * 0.007,
                  bottom: height * 0.0035,
                  left: width * 0.03,
                  right: width * 0.03),
              title: Text("John Doe",
                  style: TextStyle(fontSize: width * 0.015 + 8)),
              subtitle: Text("No. of Entries: ${entries.length}",
                  style: TextStyle(
                      color: Colors.black54, fontSize: width * 0.015 + 6)),
            ),
          ),
        );
      },
      itemCount: 1,
      shrinkWrap: true,
      padding: EdgeInsets.all(height * 0.015),
      scrollDirection: Axis.vertical,
      physics: const ScrollPhysics(),
    );
  }
}
