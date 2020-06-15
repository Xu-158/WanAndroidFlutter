import 'package:flutter/material.dart';
import 'package:wanandroidflutter/common/global.dart';

class RowTileWidget extends StatelessWidget {
  final String title;
  final Function onTap;
  final Widget icon;

  const RowTileWidget({Key key, this.title, this.onTap, this.icon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.px,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: InkWell(
          child: Row(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 10), child: icon),
              Container(
                child: Text(title,
                    style: TextStyle(fontSize: 18, color: Colors.black)),
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
              )
            ],
          ),
          onTap: onTap),
    );
  }
}
