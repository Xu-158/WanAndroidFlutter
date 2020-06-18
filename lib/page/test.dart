import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanandroidflutter/common/global.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: ListView.builder(itemBuilder: (c, index) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
          child: BubbleMessage(
            isHost: index.isOdd,
            message: "阿斯打斯打打斯打斯打打斯打斯斯打打打斯打斯斯打斯打斯打打斯打斯斯打斯打斯斯打斯打打斯打斯斯打斯打斯打打斯打斯斯打斯打斯打打斯打斯打打斯打斯打斯打",
          ),
        );
      })),
    );
  }
}

class BubbleMessage extends StatelessWidget {
  final String message;
  final bool isHost;
  const BubbleMessage({Key key, this.message, this.isHost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: pi * (isHost ? 1 : 2),
      child: Container(
        width: winWidth,
        child: Row(
          crossAxisAlignment: isHost ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                width: 50,
                child: Transform.rotate(
                  angle: pi * (isHost ? 1 : 2),
                  child: FlutterLogo(
                    size: 50,
                  ),
                )),
            Expanded(
              child: ClipPath(
                clipper: TPath(isHost),
                child: Container(
                  color: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10)
                      .add(EdgeInsets.only(left: 10)),
                  child: Transform.rotate(
                    angle: pi * (isHost ? 1 : 2),
                    child: Text(
                      message,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TPath extends CustomClipper<Path> {
  static const _ArrowWidth = 15.0;
  static const _contentHeight = 30.0;
  static const _contentWidth = 60.0;

  static const _contentHeight1 = -30.0;

  final bool isHost;

  TPath(this.isHost);

  @override
  getClip(Size size) {
//    Path path1 = Path();
//    Path path2 = Path();
//    final centerPoint = (size.height / 2).clamp(_contentHeight / 2, _contentWidth / 2);
//    if (isHost) {
//      path1.moveTo(size.width, centerPoint);
//      path1.lineTo(size.width - _ArrowWidth, centerPoint + _ArrowWidth / 2);
//      path1.lineTo(size.width - _ArrowWidth, centerPoint - _ArrowWidth / 2);
//      path1.close();
//    } else {
//      path1.moveTo(0, centerPoint);
//      path1.lineTo(_ArrowWidth, centerPoint - _ArrowWidth / 2);
//      path1.lineTo(_ArrowWidth, centerPoint + _ArrowWidth / 2);
//      path1.close();
//    }
//
//    Rect rect = Rect.fromLTWH(isHost ? 0 : _ArrowWidth, 0, (size.width - _ArrowWidth), size.height);
//    path2.addRRect(RRect.fromRectAndRadius(rect, Radius.circular(10)));
//    path1.addPath(path2, Offset.zero);
//    return path1;

    Path path1 = Path();
    Path path2 = Path();
    final centerPoint = isHost
        ? (size.height / 2).clamp(size.height + _contentHeight1, size.height + _contentWidth)
        : (size.height / 2).clamp(_contentHeight / 2, _contentWidth / 2);
    path1.moveTo(0, centerPoint);
    path1.lineTo(_ArrowWidth, centerPoint - _ArrowWidth / 2);
    path1.lineTo(_ArrowWidth, centerPoint + _ArrowWidth / 2);
    path1.close();

    Rect rect = Rect.fromLTWH(_ArrowWidth, 0, (size.width - _ArrowWidth), size.height);
    path2.addRRect(RRect.fromRectAndRadius(rect, Radius.circular(10)));
    path1.addPath(path2, Offset.zero);
    return path1;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
