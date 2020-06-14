import 'package:flutter/material.dart';
import 'package:wanandroidflutter/common/global.dart';

class RowTileWidget extends StatelessWidget {
  final String title;
  final Function onTap;

  const RowTileWidget({Key key, this.title, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.px,
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          color: themeColor,
          border: Border.symmetric(vertical: BorderSide(color: Colors.grey))),
      child: InkWell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Text(title,
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              )
            ],
          ),
          onTap: onTap),
    );
  }
}
