import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'bouncing.dart';
import 'fade_animations.dart';

import 'package:dart_sentiment/dart_sentiment.dart';
import 'package:collection/collection.dart';


class ProviderDashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProviderDashboardState();
}

class _ProviderDashboardState extends State<ProviderDashboard> {
  @override
  void initState() {
    super.initState();

    _readEntries();
  }

  // Read entries and basic sentiment analysis
  Future<void> _readEntries() async {
    final dataDir = await getApplicationDocumentsDirectory();
    final sent_analyzer = Sentiment();

    List<Map<String, dynamic>> entries = [];
    List<double> sentiment = [];

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
                sent = sent_analyzer.analysis(entry['journal']![0])['comparative'];
              }

              entries_tmp.add(entry);
              sentiment_tmp.add(sent);

              print(entry['journal']![0]);
              print(sent);
            }
          }

          if (ListEquality().equals(entries_tmp, entries)) {
            setState(() {
              entries = entries_tmp;
              sentiment = sentiment_tmp;
            });
          }
        }
      });
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
              backgroundColor: Colors.indigo,
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
                                    left: 16, right: 16, top: height * 0.02),
                                child: Text("Hi Dr. House M.D.!",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: width * 0.10,
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
                                                                "Days on Regiment:\n",
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
                                                            text: "5",
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
                  /*FadeAnimation(
                    2.0,
                    null,
                  ),*/
                ],
              ))),
    );
  }
}
