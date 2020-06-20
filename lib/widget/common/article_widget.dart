import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:wanandroidflutter/common/theme.dart';
import 'package:wanandroidflutter/widget/common/small_widget.dart';
import 'package:html/dom.dart' as dom;

// ignore: must_be_immutable
class ArticleTileWidget extends StatefulWidget {
  final Function onTap;
  final String title;
  final String subTitle;
  final String time;
  final doCollect;
  bool isCollect;

  ArticleTileWidget(
      {this.onTap,
      this.title = "",
      this.subTitle,
      this.time,
      this.doCollect,
      this.isCollect = false});
  @override
  _ArticleTileWidgetState createState() => _ArticleTileWidgetState();
}

class _ArticleTileWidgetState extends State<ArticleTileWidget>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: Duration(milliseconds: 800),
        vsync: this,
        lowerBound: pi*2,
        upperBound: pi*3)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animationController.reverse();
        }
      });
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.bounceInOut);
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color tColor = Provider.of<AppTheme>(context, listen: true).getThemeColor;
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  color: tColor, borderRadius: BorderRadius.circular(10)),
              child: Html(
                data: widget.title,
                customTextStyle: (dom.Node node, TextStyle baseStyle) {
                  if (node is dom.Element) {
                    switch (node.localName) {
                      case "em":
                        return baseStyle.merge(
                          TextStyle(
                              color: Colors.yellow.withOpacity(0.8),
                              fontWeight: FontWeight.bold,
                              height: 1,
                              fontSize: 20),
                        );
                    }
                  }
                  return baseStyle;
                },
                defaultTextStyle: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            SmallWidget(
              bgColor: tColor,
              textWidget: Row(
                children: <Widget>[
                  Text(
                    widget.subTitle == ''
                        ? 'by : 未知'
                        : 'by : ${widget.subTitle}',
                    style: TextStyle(color: Colors.white),
                  ),
                  Spacer(),
                  Text(
                    widget.time,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(width: 10),
                  Transform.rotate(
                    angle: animationController.value,
                    child: Transform.scale(
                      scale: animationController.value/6,
                      child: InkWell(
                        child: widget.isCollect
                            ? Icon(Icons.favorite,
                                size: 28,
                                color: tColor == Colors.red
                                    ? Colors.red[900]
                                    : Colors.red)
                            : Icon(Icons.favorite_border,
                                size: 28, color: Colors.white),
                        onTap: () {
                          animationController.forward();
                          widget.doCollect().then((value) {
                            if (value) {
                              setState(() {
                                widget.isCollect = !widget.isCollect;
                              });
                            }
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      onTap: widget.onTap,
    );
  }
}
