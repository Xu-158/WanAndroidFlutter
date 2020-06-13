import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:wanandroidflutter/common/global.dart';
import 'package:wanandroidflutter/widget/common/small_widget.dart';
import 'package:html/dom.dart' as dom;

class ArticleTileWidget extends StatelessWidget {
  final Function onTap;
  final String title;
  final String subTitle;
  final String time;

  ArticleTileWidget({this.onTap, this.title = "", this.subTitle, this.time});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Column(
          children: <Widget>[
            SmallWidget(
              height: 70.px,
              width: winWidth,
              textWidget: SingleChildScrollView(
                child: Html(
                  data: title,
                  customTextStyle: (dom.Node node, TextStyle baseStyle) {
                    if (node is dom.Element) {
                      switch (node.localName) {
                        case "em":
                          return baseStyle.merge(TextStyle(
                              color: Colors.yellow.withOpacity(0.8),
                              fontWeight: FontWeight.bold,
                              height: 1,
                              fontSize: 20));
                      }
                    }
                    return baseStyle;
                  },
                  defaultTextStyle: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              bgColor: themeColor,
            ),
            SmallWidget(
              bgColor: themeColor,
              textWidget: Row(
                children: <Widget>[
                  Text(
                    subTitle == '' ? 'by : 未知' : 'by : $subTitle',
                    style: TextStyle(color: Colors.white),
                  ),
                  Spacer(),
                  Text(
                    time,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
