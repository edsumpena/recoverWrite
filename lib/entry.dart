import 'package:flutter/material.dart';

import 'FoldableWidget.dart';

class Entry extends StatefulWidget {
  const Entry({
    Key? key,
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

    double bigHeight = height * 0.21;
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
                                              "Weeks 1 - 10 Regiment",
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
                                                color: Colors.grey),
                                            maxLines: 1,
                                          ),
                                          SizedBox(height: height * 0.0075),
                                          const Text(
                                            "Take a nap, go to sleep.",
                                            style: TextStyle(
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
                                              "Weeks 1 - 10 Regiment",
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
                                              minWidth: width * 0.625,
                                              maxWidth: width * 0.625,
                                              minHeight: height * 0.030,
                                              maxHeight: height * 0.030,
                                            ),
                                            child: const Text("Summary:",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1),
                                          ),
                                          SizedBox(height: height * 0.0075),
                                          ConstrainedBox(
                                            constraints: BoxConstraints(
                                              minWidth: width * 0.625,
                                              maxWidth: width * 0.625,
                                              minHeight: height * 0.030,
                                              maxHeight: height * 0.030,
                                            ),
                                            child: const Text("Do some cool stuff",
                                                style: TextStyle(
                                                    fontSize: 14),
                                                overflow: TextOverflow.ellipsis,),
                                          ),
                                        ])))),
                      ]))),
          next: Column(
            children: [
              _section1(foldedHeight1, context, "Step 2:", "Go out, drink a beer."),
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
                behind: _section1(foldedHeight2, context, "Step 3:", "Pass out on your bed, sleep 'til noon."),
                front: Container(
                  height: foldedHeight2,
                  color: Colors.white,
                ),
                next: _section1(foldedHeight3, context, "Step 4:", "Realize that hangovers suck."),
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
                                        minWidth: width * 0.55,
                                        maxWidth: width * 0.55,
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
                                    ConstrainedBox(
                                      constraints: BoxConstraints(
                                        minWidth: width * 0.70,
                                        maxWidth: width * 0.70,
                                        minHeight: height * 0.05,
                                        maxHeight: height * 0.05,
                                      ),
                                      child: Text(
                                        content,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.ellipsis,
                                            color: Colors.grey),
                                      ),
                                    ),
                                    SizedBox(height: height * 0.0075),
                                  ]))))
                ])));
  }
}
