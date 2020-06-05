import 'package:flutter/material.dart';
import 'package:wanandroidflutter/common/global.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('homepage'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 250.px,
                  height: 200.1.px,
                  color: Colors.red,
                ),
                Container(
                  width: 250.px,
                  height: 200.px,
                  color: Colors.blue,
                ),
                Container(
                  width:250,
                  height: 200,
                  color: Colors.green,
                )
              ],
            ),
          ),
        ));
  }
}
