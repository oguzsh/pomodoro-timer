import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:pomodoro_timer/models/CustomTimerPainter.dart';

class PomodoroScreen extends StatefulWidget {
  @override
  _PomodoroScreenState createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen>
    with TickerProviderStateMixin {
  // Switch states
  bool soundSwitch = true;
  bool vibrationSwitch = true;
  int _workSessionValue = 1;
  int _shortBreakValue = 1;
  int _longBreakValue = 1;
  NumberPicker integerNumberPicker;

// Work Session
  _handleWorkValueChange(num value) {
    if (value != null) {
      setState(() {
        _workSessionValue = value;
      });
    }
  }

  _handleWorkValueChangedExternally(num value) {
    if (value != null) {
      setState(() {
        _workSessionValue = value;
      });
      integerNumberPicker.animateInt(value);
    }
  }

  // Short break
  _handleShortBreakValueChange(num value) {
    if (value != null) {
      setState(() {
        _shortBreakValue = value;
      });
    }
  }

  _handleShortBreakValueChangedExternally(num value) {
    if (value != null) {
      setState(() {
        _shortBreakValue = value;
      });
      integerNumberPicker.animateInt(value);
    }
  }

  // Long Break

  _handleLongBreakValueChange(num value) {
    if (value != null) {
      setState(() {
        _longBreakValue = value;
      });
    }
  }

  _handleLongBreakChangedExternally(num value) {
    if (value != null) {
      setState(() {
        _longBreakValue = value;
      });
      integerNumberPicker.animateInt(value);
    }
  }

  // Animation
  AnimationController animationController;

  String get timerString {
    Duration duration =
        animationController.duration * animationController.value;
    return '${duration.inMinutes.toString().padLeft(2, '0')}\n${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  _onSoundSwitchChanged(bool value) {
    (soundSwitch == false)
        ? setState(() {
            soundSwitch = true;
          })
        : setState(() {
            soundSwitch = false;
          });
  }

  _onVibrationSwitchChanged(bool value) {
    (vibrationSwitch == false)
        ? setState(() {
            vibrationSwitch = true;
          })
        : setState(() {
            vibrationSwitch = false;
          });
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1500));
  }

  @override
  Widget build(BuildContext context) {
    final Brightness brightnessValue =
        MediaQuery.of(context).platformBrightness;
    bool isDark = brightnessValue == Brightness.dark;

    integerNumberPicker = new NumberPicker.integer(
      initialValue: _workSessionValue,
      minValue: 1,
      maxValue: 50,
      onChanged: _handleWorkValueChange,
    );

    integerNumberPicker = new NumberPicker.integer(
      initialValue: _shortBreakValue,
      minValue: 1,
      maxValue: 50,
      onChanged: _handleShortBreakValueChange,
    );

    integerNumberPicker = new NumberPicker.integer(
      initialValue: _longBreakValue,
      minValue: 1,
      maxValue: 50,
      onChanged: _handleLongBreakValueChange,
    );

    return Scaffold(
        backgroundColor: (isDark)
            ? Color.fromRGBO(38, 38, 52, 1)
            : Color.fromRGBO(242, 62, 60, 1),
        body: AnimatedBuilder(
            animation: animationController,
            builder: (context, child) {
              return Container(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Align(
                      alignment: FractionalOffset.topCenter,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 52, right: 52, bottom: 0, top: 70),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Stack(
                            children: <Widget>[
                              Positioned.fill(
                                child: AnimatedBuilder(
                                    animation: animationController,
                                    builder:
                                        (BuildContext context, Widget child) {
                                      return CustomPaint(
                                        painter: CustomTimerPainter(
                                            animation: animationController,
                                            backgroundColor: Colors.white,
                                            color: (isDark)
                                                ? Color.fromRGBO(92, 211, 62, 1)
                                                : Color.fromRGBO(175, 8, 8, 1)),
                                      );
                                    }),
                              ),
                              Align(
                                alignment: FractionalOffset.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    AnimatedBuilder(
                                      animation: animationController,
                                      builder:
                                          (BuildContext context, Widget child) {
                                        return Text(
                                          timerString,
                                          style: TextStyle(
                                              fontSize: 85.0,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.white),
                                        );
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 60),
                          child: Text(
                            "Task Name",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                shadows: [
                                  Shadow(
                                      blurRadius: 5,
                                      color: Color.fromRGBO(0, 0, 0, 0.5),
                                      offset: Offset(0, 3))
                                ],
                                fontSize: 40),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 55),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "0/4",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 4,
                                  shadows: [
                                    Shadow(
                                        blurRadius: 5,
                                        color: Color.fromRGBO(0, 0, 0, 0.2),
                                        offset: Offset(0, 3))
                                  ],
                                ),
                              ),
                              Text(
                                "Count",
                                style: TextStyle(
                                    letterSpacing: 1.1,
                                    color: Colors.white,
                                    fontSize: 22,
                                    shadows: [
                                      Shadow(
                                          blurRadius: 5,
                                          color: Color.fromRGBO(0, 0, 0, 0.3),
                                          offset: Offset(0, 3))
                                    ],
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        new AnimatedBuilder(
                          animation: animationController,
                          builder: (context, child) {
                            return Container(
                              width: 75.0,
                              height: 75.0,
                              child: new RawMaterialButton(
                                fillColor: Colors.white,
                                shape: new CircleBorder(),
                                elevation: 1.0,
                                child: new Icon(
                                  (animationController.isAnimating)
                                      ? CupertinoIcons.pause_solid
                                      : CupertinoIcons.play_arrow_solid,
                                  size: 48,
                                  color: (isDark)
                                      ? Color.fromRGBO(92, 211, 62, 1)
                                      : Color.fromRGBO(242, 60, 62, 1),
                                ),
                                onPressed: () {
                                  if (animationController.isAnimating) {
                                    animationController.stop();
                                  } else {
                                    animationController.reverse(
                                        from: animationController.value == 0.0
                                            ? 1.0
                                            : animationController.value);
                                  }
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ));
            }),
        floatingActionButton: Container(
          padding: EdgeInsets.only(top: 40),
          child: Align(
            alignment: Alignment.topLeft,
            child: FloatingActionButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(45))),
              child: Icon(
                CupertinoIcons.settings_solid,
                color: (isDark)
                    ? Color.fromRGBO(92, 211, 62, 1)
                    : Color.fromRGBO(242, 62, 60, 1),
                size: 32,
              ),
              elevation: 0.0,
              backgroundColor: Colors.white,
              onPressed: () {
                _openSettingsModal(isDark);
              },
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }

  void _openSettingsModal(bool isDark) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Settings",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.w700),
                  ),
                  Divider(
                    thickness: 2,
                    color: Colors.black26,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Sound",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.w400),
                      ),
                      Row(
                        children: <Widget>[
                          Transform.scale(
                            scale: 1.3,
                            child: Switch(
                              activeColor: (isDark)
                                  ? Color.fromRGBO(92, 211, 62, 1)
                                  : Color.fromRGBO(242, 62, 60, 1),
                              inactiveTrackColor:
                                  Color.fromRGBO(157, 171, 192, 1),
                              onChanged: _onSoundSwitchChanged,
                              value: soundSwitch,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Vibration",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.w400),
                      ),
                      Row(
                        children: <Widget>[
                          Transform.scale(
                            scale: 1.3,
                            child: Switch(
                              activeColor: (isDark)
                                  ? Color.fromRGBO(92, 211, 62, 1)
                                  : Color.fromRGBO(242, 62, 60, 1),
                              inactiveTrackColor:
                                  Color.fromRGBO(157, 171, 192, 1),
                              onChanged: _onVibrationSwitchChanged,
                              value: vibrationSwitch,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Timer",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                          fontWeight: FontWeight.w700)),
                  Divider(
                    thickness: 2,
                    color: Colors.black26,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Work session",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.w400),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 30,
                              height: 30,
                              child: RawMaterialButton(
                                shape: new CircleBorder(),
                                onPressed: _showWorkSessionDialog,
                                fillColor: (isDark)
                                    ? Color.fromRGBO(92, 211, 62, 1)
                                    : Color.fromRGBO(242, 62, 60, 1),
                                elevation: 0,
                                child: Text(
                                  "$_workSessionValue",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                "min",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Short Break",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.w400),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 30,
                              height: 30,
                              child: RawMaterialButton(
                                shape: new CircleBorder(),
                                onPressed: _showShortBreakDialog,
                                fillColor: (isDark)
                                    ? Color.fromRGBO(92, 211, 62, 1)
                                    : Color.fromRGBO(242, 62, 60, 1),
                                elevation: 0,
                                child: Text(
                                  "$_shortBreakValue",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                "min",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Long Break",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.w400),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 30,
                              height: 30,
                              child: RawMaterialButton(
                                shape: new CircleBorder(),
                                onPressed: _showLongBreakDialog,
                                fillColor: (isDark)
                                    ? Color.fromRGBO(92, 211, 62, 1)
                                    : Color.fromRGBO(242, 62, 60, 1),
                                elevation: 0,
                                child: Text(
                                  "$_longBreakValue",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                "min",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _showWorkSessionDialog() {
    showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return new NumberPickerDialog.integer(
          minValue: 0,
          maxValue: 50,
          initialIntegerValue: _workSessionValue,
          title: Text("Select a minute"),
        );
      },
    ).then(_handleWorkValueChangedExternally);
  }

  _showShortBreakDialog() {
    showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return new NumberPickerDialog.integer(
          minValue: 0,
          maxValue: 50,
          initialIntegerValue: _shortBreakValue,
          title: Text("Select a minute"),
        );
      },
    ).then(_handleShortBreakValueChangedExternally);
  }

  _showLongBreakDialog() {
    showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return new NumberPickerDialog.integer(
          minValue: 0,
          maxValue: 50,
          initialIntegerValue: _longBreakValue,
          title: Text("Select a minute"),
        );
      },
    ).then(_handleLongBreakChangedExternally);
  }
}
