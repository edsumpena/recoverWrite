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

                        ])
                )
            )
        )
    );
  }
}
