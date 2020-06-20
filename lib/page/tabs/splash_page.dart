import 'dart:math';
import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:wanandroidflutter/root_page.dart';
import 'package:wanandroidflutter/util/navigator_util.dart';
import 'package:wanandroidflutter/common/global.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: Duration(milliseconds: 2000),
        vsync: this,
        lowerBound: 0.0,
        upperBound: 50.0)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          NavigatorUtil.pushAndRemoveUntil(RootPage());
        }
      });
    animation = CurvedAnimation(
        parent: _animationController, curve: Curves.bounceInOut);
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: winHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Opacity(
              opacity: 1- _animationController.value * 2 / 100,
              child: Container(
                alignment: Alignment.center,
                child: Transform.rotate(
                  angle: _animationController.value / 8,
                  child: Transform(
                    transform:
                        Matrix4.rotationX(_animationController.value / 25 * pi),
                    child: Transform.scale(
                      scale: _animationController.value / 12,
                      child: CustomPaint(
                        painter: ClockPainter(
                            animationValue: _animationController.value),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Opacity(
              opacity: _animationController.value * 2 / 100,
              child: FlutterLogo(
                size: 200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  ClockPainter({this.animationValue});
  static Color clockColor = Colors.black87;
  double animationValue;

  Paint _bigCirclePaint = new Paint()
    ..color = clockColor
    ..style = PaintingStyle.stroke
    ..strokeWidth = 8;

  Paint _linePaint = new Paint()
    ..color = clockColor
    ..style = PaintingStyle.fill
    ..strokeWidth = 4
    ..isAntiAlias = true;

  Offset _center = Offset.zero;

  double _radius = 140;

  TextPainter textPainter =
      TextPainter(textAlign: TextAlign.left, textDirection: TextDirection.ltr);

  @override
  void paint(Canvas canvas, Size size) async {
    canvas.drawCircle(_center, _radius, _bigCirclePaint);
    _bigCirclePaint.style = PaintingStyle.fill;
    canvas.drawCircle(_center, _radius / 22, _bigCirclePaint);
    for (int i = 0; i < 60; i++) {
      _linePaint.strokeWidth = i % 5 == 0 ? i % 3 == 0 ? 5 : 3 : 1;
      canvas.drawLine(Offset(0, _radius - 10), Offset(0, _radius), _linePaint);
      canvas.rotate(2 * pi / 60);
    }
    for (int i = 0; i < 12; i++) {
      canvas.save();
      canvas.translate(0.0, -_radius + 30);
      textPainter.text = TextSpan(
          style: TextStyle(color: clockColor, fontSize: 18),
          text: '${i == 0 ? 12 : i}');
      canvas.rotate(-2 * pi / 12 * i);
      textPainter.layout();
      textPainter.paint(
          canvas, Offset(-textPainter.width / 2, -textPainter.height / 2));
      canvas.restore();
      canvas.rotate(2 * pi / 12);
    }


    ///正常的时钟 时分秒
//    DateTime dateTime = DateTime.now();
//    int hour = dateTime.hour;
//    int minutes = dateTime.minute;
//    int seconds = dateTime.second;
//    double _hourAngle = 2 * pi / 12 * hour;
//    _linePaint.strokeWidth = 6;
//    canvas.rotate(_hourAngle);
//    canvas.drawLine(Offset.zero, Offset(0, -_radius + 70), _linePaint);
//    double _minutesAngle = 2 * pi / 60 * minutes ;
//    _linePaint.strokeWidth = 4;
//    canvas.rotate(_minutesAngle-_hourAngle);
//    canvas.drawLine(Offset.zero, Offset(0, -_radius + 60), _linePaint);
//    double _secondsAngle = 2 * pi / 60 * seconds;
//    _linePaint.strokeWidth = 2;
//    canvas.rotate(_secondsAngle-_minutesAngle);
//    canvas.drawLine(Offset.zero, Offset(0, -_radius + 50), _linePaint);

    ///不正常的时钟 时分秒
    double _hourAngle = animationValue / 5;
    _linePaint.strokeWidth = 6;
    canvas.rotate(_hourAngle);
    canvas.drawLine(Offset.zero, Offset(0, -_radius + 70), _linePaint);
    double _minutesAngle = animationValue / 2;
    _linePaint.strokeWidth = 4;
    canvas.rotate(_minutesAngle - _hourAngle);
    canvas.drawLine(Offset.zero, Offset(0, -_radius + 60), _linePaint);
    double _secondsAngle = animationValue;
    _linePaint.strokeWidth = 2;
    canvas.rotate(_secondsAngle - _minutesAngle);
    canvas.drawLine(Offset.zero, Offset(0, -_radius + 50), _linePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
