import 'dart:math';
import 'package:vector_math/vector_math.dart' as Vector;

import 'package:flutter/material.dart';

import 'animation/waveclipper.dart';

class WaveViewModel extends StatefulWidget {
  final Size size;
  final int xOffset;
  final int yOffset;
  final Color color;

  WaveViewModel(
      {Key key,
      @required this.size,
      this.xOffset = 0,
      this.yOffset = 0,
      this.color})
      : super(key: key);
  @override
  _WaveViewModelState createState() => _WaveViewModelState();
}

class _WaveViewModelState extends State<WaveViewModel>
    with TickerProviderStateMixin {
  AnimationController animationController;
  List<Offset> animList = [];

  @override
  initState() {
    super.initState();
    animationController = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: 1),
    );

    animationController.addListener(
      () {
        animList.clear();
        for (int i = -2 - widget.xOffset;
            i <= widget.size.width.toInt() + 2;
            i++) {
          animList.add(
            new Offset(
              i.toDouble() + widget.xOffset,
              sin((animationController.value * 360 - i) %
                          360 *
                          Vector.degrees2Radians) *
                      10 +
                  30 +
                  widget.yOffset,
            ),
          );
        }
      },
    );
    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: new AnimatedBuilder(
        animation: new CurvedAnimation(
          parent: animationController,
          curve: Curves.easeInOut,
        ),
        builder: (context, child) => new ClipPath(
          child: new Container(
            width: widget.size.width,
            height: widget.size.height,
            color: widget.color,
          ),
          clipper: new WaveClipper(
            animationController.value,
            animList,
          ),
        ),
      ),
    );
  }
}
