import 'package:flutter/material.dart';

import 'FoldableWidget.dart';

class Regiment extends StatefulWidget {
  const Regiment({
    Key? key,
  }) : super(key: key);

  @override
  State<Regiment> createState() => _RegimentState();
}

class _RegimentState extends State<Regiment> with SingleTickerProviderStateMixin {
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

    double bigHeight = height * 0.235;
    double foldedHeight1 = height * 0.15;
    double foldedHeight2 = height * 0.15;
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
                                  color: const Color(0xff4e1dc2),
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
                                              "Exercises for Weeks 1-10",
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
                                            "Step 1:",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                overflow: TextOverflow.ellipsis,
                                                color: Colors.black),
                                            maxLines: 1,
                                          ),
                                          const Text(
                                            "Exercise: Do 10 shoulder rolls\nPurpose: Increase range of motion",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                overflow: TextOverflow.ellipsis,
                                                color: Color(0xff5a5a5a)),
                                            maxLines: 3,
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
                                  color: const Color(0xff4e1dc2),
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
                                              "Exercises for Weeks 1-10",
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
                                          ConstrainedBox(
                                            constraints: BoxConstraints(
                                              minWidth: width * 0.725,
                                              maxWidth: width * 0.725,
                                              minHeight: height * 0.12,
                                              maxHeight: height * 0.12,
                                            ),
                                            child: const Text("Summary: Complete 3x a week for 1 hour\n\nClick for more details",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 4),
                                          ),
                                          SizedBox(height: height * 0.0075),

                                        ])))),
                      ]))),
          next: Column(
            children: [
              _section1(foldedHeight1, context, "Step 2:", "Exercise: Do 3 sets of 12 lateral raises\nPurpose: Increase range of motion"),
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
                behind: _section1(foldedHeight2, context, "Step 3:", "Exercise: Do 3 sets of 5 tricep dips\nPurpose: Build muscle in upper body"),
                front: Container(
                  height: foldedHeight2,
                  color: Colors.white,
                ),
                next: _section1(foldedHeight3, context, "Step 4:", "Exercise: Do deep breathing for 5 minutes\nPurpose: Increase aerobic respiration"),
              ),
            ],
          ),
        ));
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
                                            color: Colors.black),
                                        maxLines: 1,
                                      ),
                                    ),
                                    SizedBox(height: height * 0.0075),
                                    ConstrainedBox(
                                      constraints: BoxConstraints(
                                        minWidth: width * 0.70,
                                        maxWidth: width * 0.70,
                                        minHeight: height * 0.075,
                                        maxHeight: height * 0.075,
                                      ),
                                      child: Text(
                                        content,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.ellipsis,
                                            color: Color(0xff5a5a5a)),
                                        maxLines: 5,
                                      ),
                                    ),
                                    SizedBox(height: height * 0.0075),
                                  ]))))
                ])));
  }
}
