import 'dart:collection';

import 'package:flutter/material.dart';

import 'FoldableWidget.dart';

class Entry extends StatefulWidget {
  final Map<String, dynamic>? entry;
  final int? sentiment_risk;
  const Entry({
    Key? key,
    required this.entry,
    required this.sentiment_risk
  }) : super(key: key);

  @override
  State<Entry> createState() => _EntryState();
}

class _EntryState extends State<Entry> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final Duration duration = const Duration(milliseconds: 1000);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleAnimation() {
    if (_controller.status == AnimationStatus.completed) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    double bigHeight = height * 0.225;
    double foldedHeight1 = height * 0.125;
    double foldedHeight2 = height * 0.14;
    double foldedHeight3 = height * 0.1725;

    return GestureDetector(
        onTap: _toggleAnimation,
        child: AnimatedFoldingWidget(
          animation: Tween(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: _controller,
              curve: const Interval(
                0.0,
                1 / 3,
                curve: Curves.easeInOut,
              ),
            ),
          ),
          behind: SizedBox(
              height: bigHeight,
              child: Card(
                  margin: const EdgeInsets.all(0),
                  elevation: 0,
                  color: Colors.transparent,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                            flex: 3,
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.indigoAccent,
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(width * 0.035)),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(width * 0.025),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ConstrainedBox(
                                          constraints: BoxConstraints(
                                            minWidth: width * 0.85,
                                            maxWidth: width * 0.85,
                                            minHeight: height * 0.035,
                                            maxHeight: height * 0.035,
                                          ),
                                          child: const Center(
                                            child: Text(
                                              "John's Entry",
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold,
                                                  overflow: TextOverflow.ellipsis,
                                                  color: Colors.white
                                              ),
                                              maxLines: 1,
                                            ),
                                          ),
                                ),
                                      ]),
                                ))),
                        Expanded(
                            flex: 5,
                            child: Container(
                                color: Colors.white,
                                child: Padding(
                                    padding: EdgeInsets.all(width * 0.025),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "General Information:",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                overflow: TextOverflow.ellipsis,
                                                color: Colors.grey),
                                            maxLines: 1,
                                          ),
                                          SizedBox(height: height * 0.0075),
                                          Text(
                                            "Completed Regiment: ${widget.entry == null ? "" : widget.entry!["completeRegiment"]![0]}",
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                overflow: TextOverflow.ellipsis,
                                                color: Colors.grey),
                                          ),
                                          SizedBox(height: height * 0.0075),
                                          Text(
                                            "Time Spent: ${widget.entry == null ? "" : widget.entry!["timeSpent"]![0]}",
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                overflow: TextOverflow.ellipsis,
                                                color: Colors.grey),
                                          ),
                                          SizedBox(height: height * 0.0075),
                                          Text(
                                            "Emotional State: ${widget.entry == null ? "" : _getEmotion()}",
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                overflow: TextOverflow.ellipsis,
                                                color: Colors.grey),
                                          ),
                                          SizedBox(height: height * 0.004),
                                        ])))),
                      ]))),
          front: SizedBox(
              height: bigHeight,
              child: Card(
                  margin: const EdgeInsets.all(0),
                  elevation: 0,
                  color: Colors.transparent,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                            flex: 1,
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.indigoAccent,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(width * 0.035),
                                      topRight: Radius.circular(width * 0.035)),
                                ),
                                child: Padding(
                                    padding: EdgeInsets.all(width * 0.025),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ConstrainedBox(
                                            constraints: BoxConstraints(
                                              minWidth: width * 0.85,
                                              maxWidth: width * 0.85,
                                              minHeight: height * 0.035,
                                              maxHeight: height * 0.035,
                                            ),
                                            child: const Text(
                                              "John's Entry",
                                              style: TextStyle(
                                                fontSize: 22,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                            ),
                                          )
                                        ])))),
                        Expanded(
                            flex: 2,
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft:
                                          Radius.circular(width * 0.035),
                                      bottomRight:
                                          Radius.circular(width * 0.035)),
                                ),
                                child: Padding(
                                    padding: EdgeInsets.all(width * 0.025),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                const TextSpan(
                                                  text: "Sentiment Analysis Risk:  ",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black,
                                                    fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                                _sentimentRiskIcon()
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: height * 0.0075),
                                          Text("Completed Regiment: ${widget.entry == null ? "" : widget.entry!["completeRegiment"]![0]}",
                                                style: const TextStyle(
                                                    fontSize: 14),
                                              maxLines: 1,
                                                overflow: TextOverflow.ellipsis,),
                                          Text("Time Spent: ${widget.entry == null ? "" : widget.entry!["timeSpent"]![0]}",
                                            style: const TextStyle(
                                                fontSize: 14),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,),
                                          Text("Emotional State: ${widget.entry == null ? "" : _getEmotion()}",
                                            style: const TextStyle(
                                                fontSize: 14),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,),
                                        ])))),
                      ]))),
          next: Column(
            children: [
              _section1(foldedHeight1, context, "Completed Exercises:", widget.entry == null ? "" : widget.entry!["completeDescription"]![0]),
              AnimatedFoldingWidget(
                animation: Tween(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                    parent: _controller,
                    curve: const Interval(
                      1 / 3,
                      1 / 3 * 2,
                      curve: Curves.easeInOut,
                    ),
                  ),
                ),
                behind: _section1(foldedHeight2, context, "Uncompleted Exercises:", widget.entry == null ? "" : widget.entry!["noCompleteDescription"]![0]),
                front: Container(
                  height: foldedHeight2,
                  color: Colors.white,
                ),
                next: _section1(foldedHeight3, context, "Feelings, Thoughts, and Challenges:", widget.entry == null ? "" : widget.entry!["journal"]![0]),
              ),
            ],
          ),
        ));
  }

  String _getEmotion() {
    String str = widget.entry!["emotion"]!.toString().replaceAll("[", "");
    str = str.replaceAll("]", "");
    return str;
  }

  WidgetSpan _sentimentRiskIcon() {
    if (widget.sentiment_risk == 0) {
      return const WidgetSpan(
          child: IconTheme(
        data: IconThemeData(
            color: Colors.green),
        child: Icon(
          Icons.check_box, size: 22,),
      ));
    } else if (widget.sentiment_risk == 1) {
      return const WidgetSpan(
          child: IconTheme(
        data: IconThemeData(
            color: Colors.amber),
        child: Icon(
          Icons.access_time_filled, size: 22,),
      ));
    } else {
      return const WidgetSpan(
          child: IconTheme(
        data: IconThemeData(
            color: Colors.red),
        child: Icon(
          Icons.warning, size: 22,),
      ));
    }
  }

  Widget _section1(
      double widgetHeight, BuildContext context, String title, String content) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
        height: widgetHeight,
        child: Card(
            margin: const EdgeInsets.all(0),
            elevation: 0,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: Container(
                          color: Colors.white,
                          child: Padding(
                              padding: EdgeInsets.all(width * 0.025),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ConstrainedBox(
                                      constraints: BoxConstraints(
                                        minWidth: width * 0.75,
                                        maxWidth: width * 0.75,
                                        minHeight: height * 0.0305,
                                        maxHeight: height * 0.0305,
                                      ),
                                      child: Text(
                                        title,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.ellipsis,
                                            color: Colors.grey),
                                        maxLines: 1,
                                      ),
                                    ),
                                    SizedBox(height: height * 0.0075),
                          Flexible(
                              child: Text(
                                        content,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.ellipsis,
                                            color: Colors.grey),
                                        maxLines: 5,
                                      ),
                                    ),
                                    SizedBox(height: height * 0.0075),
                                  ]))))
                ])));
  }
}
