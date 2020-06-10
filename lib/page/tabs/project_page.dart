import 'package:flutter/material.dart';
import 'package:wanandroidflutter/common/global.dart';

class ProjectPage extends StatefulWidget {
  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return InkWell(
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: Text('$index'),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.symmetric(vertical: BorderSide(color: Colors.black12))
                      ),
                    )
                  );
                }),
          ),
          SizedBox(width: 10,),
          Expanded(
            flex: 3,
            child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: 20,
                itemBuilder: (context, index) {
                  return Card(
                    child: Container(
                      width: 100,
                      height: 200,
                      child: Text('1a2ds3asd'),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
