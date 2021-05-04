import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClockPaint extends StatefulWidget {
  final double size;

  const ClockPaint({Key key, this.size}) : super(key: key);
  @override
  _ClockPaintState createState() => _ClockPaintState();
}

class _ClockPaintState extends State<ClockPaint> {
  Timer timer;

  @override
  void initState() {
    super.initState();

    Timer.periodic(
      Duration(seconds: 1),
      (Timer t) {
        if (mounted) {
          setState(() {});
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size, // 300,
      height: widget.size, // 300,
      // adjust angle since the default starts from (1,0)
      child: Transform.rotate(
        angle: -pi / 2,
        child: CustomPaint(
          painter: ClockPainter(),
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  var dateTime = DateTime.now();

  // 60 secound has 360 degree; so 1 second is 6degree
  // 12 hours has 260 degree; so 1 hour is 30 degree, so 1 min is 0.5 degree

  @override
  void paint(Canvas canvas, Size size) {
    // center in X direction
    final _centerX = size.width / 2;
    // center in Y direction
    final _centerY = size.height / 2;
    // pointer to the middle of screen
    final _centerPoint = Offset(_centerX, _centerY);
    final radius = min(_centerX, _centerY);

    final _overFill = Paint();
    _overFill.color = Color(0xFF241f13);
    final _outlineFill = Paint();
    _outlineFill.color = Color(0xFFEAECFF);
    // set the shape and its width
    _outlineFill.style = PaintingStyle.stroke;
    _outlineFill.strokeWidth = 11;

    // clock's circle
    canvas.drawCircle(_centerPoint, radius - 20, _overFill);
    // clock's outline
    canvas.drawCircle(_centerPoint, radius - 20, _outlineFill);
    final _secondHand = Paint();
    _secondHand.color = Colors.orange[300];
    _secondHand.style = PaintingStyle.stroke;
    _secondHand.strokeCap = StrokeCap.round;
    _secondHand.strokeWidth = 5;

    final _minuteHand = Paint();
    _minuteHand.shader =
        RadialGradient(colors: [Colors.white, Colors.blue[800]]).createShader(
      Rect.fromCircle(center: _centerPoint, radius: radius),
    );
    _minuteHand.style = PaintingStyle.stroke;
    _minuteHand.strokeCap = StrokeCap.round;
    _minuteHand.strokeWidth = 10;

    final _hourHand = Paint();
    _hourHand.shader =
        RadialGradient(colors: [Color(0xFFEA74AB), Colors.white]).createShader(
      Rect.fromCircle(
        center: _centerPoint,
        radius: radius,
      ),
    );
    _hourHand.style = PaintingStyle.stroke;
    _hourHand.strokeCap = StrokeCap.round;
    _hourHand.strokeWidth = 15;

    // hour hand
    final hourHandX = _centerX +
        60 * cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    final hourHandY = _centerY +
        60 * sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    canvas.drawLine(_centerPoint, Offset(hourHandX, hourHandY), _hourHand);

    // minute hand
    final minuteHandX = _centerX + 80 * cos(dateTime.minute * 6 * pi / 180);
    final minuteHandY = _centerY + 80 * sin(dateTime.minute * 6 * pi / 180);
    canvas.drawLine(
        _centerPoint, Offset(minuteHandX, minuteHandY), _minuteHand);

    // second hand
    final secondHandX = _centerX + 80 * cos(dateTime.second * 6 * pi / 180);
    final secondHandY = _centerY + 80 * sin(dateTime.second * 6 * pi / 180);
    canvas.drawLine(
        _centerPoint, Offset(secondHandX, secondHandY), _secondHand);

    canvas.drawCircle(_centerPoint, 10, _outlineFill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
