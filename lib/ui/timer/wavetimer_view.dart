import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:routine/constant/notification_setting.dart';
import 'package:routine/models/routine_model.dart';
import 'package:routine/ui/component/round_button.dart';
import 'package:routine/ui/timer/wave_viewmodel.dart';

class WaveTimerView extends StatefulWidget {
  final RoutineModel routineModel;

  const WaveTimerView({Key key, this.routineModel}) : super(key: key);

  @override
  _WaveTimerViewState createState() => _WaveTimerViewState();
}

class _WaveTimerViewState extends State<WaveTimerView>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  var duration;
  var begin = 0.0;
  Animation<double> heightSize;
  Timer waveTimer;
  Timer stringTimer;
  Color waveColor = Colors.primaries[Random().nextInt(Colors.primaries.length)];
  final NotificationPlugin _notificationPlugin = NotificationPlugin();

  var _counter;
  var intTimeMin;
  var doubleTimeSec;

  // Store time
  // String timeText = '';
  String timeMin = '';
  String timeSec = '';
  List minAndSec = [];
  String buttonText = 'Start';

  Stopwatch stopwatch = Stopwatch();
  static const delay = Duration(microseconds: 1);

  // Visual Countdown settings
  CountDownController _countDowncontroller = new CountDownController();
  int _countDownInSecond;
  bool _isPaused = true;

  @override
  void initState() {
    super.initState();

    // get passed Hour and Minute
    minAndSec = widget.routineModel.duration.replaceAll("min", "").split(" ");
    timeMin = minAndSec[0];
    timeSec = minAndSec[2];

    intTimeMin = int.parse(minAndSec[0]) * 60;
    doubleTimeSec = int.parse(minAndSec[2]);
    _counter = intTimeMin + doubleTimeSec;
    _countDownInSecond = intTimeMin + doubleTimeSec;

    final duration = Duration(seconds: _counter);
    _controller = AnimationController(
      duration: duration,
      vsync: this,
    );
    waveTimer = Timer.periodic(delay, (Timer t) => updateClock());
  }

  // Called each time the time is ticking
  void updateClock() {
    if (stopwatch.isRunning) {
      setState(
        () {
          buttonText = "Running";
        },
      );
    } else if (stopwatch.elapsed.inSeconds == 0) {
      buttonText = "Start";
    } else {
      setState(() {
        buttonText = "Paused";
        stopwatch.stop();
      });
    }
  }

  @override
  void dispose() {
    stopwatch.stop();
    waveTimer.cancel();
    super.dispose();
  }

  // decrease the timer
  void _startTimer() {
    // min + sec = total counter as int
    if (waveTimer != null) {
      waveTimer.cancel();
    }

    // set timer every single second
    stringTimer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        // execute here every one second
        setState(
          () {
            if (_counter > 0) {
              _counter--;
            } else {
              // notify user the timer ends by vibration
              timer.cancel();
              // HapticFeedback.heavyImpact();
              // print('i am here');
              // sleep(
              //   const Duration(seconds: 5),
              // );
              // Navigator.pop(context);
            }
          },
        );
      },
    );
  }

  void _countDownStart() {
    if (_countDowncontroller != null)
      setState(() {
        _isPaused = false;
        _countDowncontroller.resume();
      });
  }

  void _countDownPause() {
    setState(() {
      _countDowncontroller.pause();
    });
  }

  CircularCountDownTimer showTimer() {
    return CircularCountDownTimer(
        duration: _countDownInSecond,
        controller: _countDowncontroller,
        width: MediaQuery.of(context).size.width / 2,
        height: MediaQuery.of(context).size.height / 2,
        color: Colors.white,
        fillColor: Colors.red,
        backgroundColor: null,
        strokeWidth: 5.0,
        strokeCap: StrokeCap.butt,
        textStyle: TextStyle(
          fontSize: 22.0,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        isReverse: true,
        isReverseAnimation: true,
        isTimerTextShown: true,
        onComplete: () {
          HapticFeedback.heavyImpact();
          print('I am here');
          _notificationPlugin.showNotification();
          sleep(
            const Duration(seconds: 1),
          );

          Navigator.pop(context);
        });
  }

  @override
  Widget build(BuildContext context) {
    heightSize =
        new Tween(begin: begin, end: MediaQuery.of(context).size.height - 65)
            .animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    // Set 2D size of width and height
    Size size = Size(MediaQuery.of(context).size.width, heightSize.value);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF212121),
        body: Stack(
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return WaveViewModel(
                  size: size,
                  color: waveColor,
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.navigate_before,
                      size: 28.0,
                      color: Colors.white70,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.only(bottom: 100),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          widget.routineModel.description,
                          style: TextStyle(
                            fontSize: 40.0,
                            color: Colors.white54,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (!_isPaused) showTimer(),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 32),
                child: GestureDetector(
                  child: RoundedButton(text: buttonText),
                  onTap: () {
                    if (stopwatch.isRunning) {
                      print('--Paused--');
                      stopwatch.stop();
                      _controller.stop(canceled: false);
                      _countDownPause();
                    } else {
                      print('--Running--');
                      begin = 50.0;
                      stopwatch.start();
                      _controller.forward();
                      _countDownStart();

                      // start decreasing _count variable
                      _startTimer();
                    }
                    updateClock();
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
