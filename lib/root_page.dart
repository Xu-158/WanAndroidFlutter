import 'package:flutter/material.dart';
import 'package:wanandroidflutter/tabs/data_page.dart';
import 'package:wanandroidflutter/tabs/home_page.dart';
import 'package:wanandroidflutter/tabs/mine_page.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {

  PageController _pageController = PageController();

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItem = [
    BottomNavigationBarItem(icon: Icon(Icons.ac_unit), title: Text('首页')),
    BottomNavigationBarItem(icon: Icon(Icons.timer), title: Text('data')),
    BottomNavigationBarItem(icon: Icon(Icons.map), title: Text('我的')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[HomePage(), DataPage(), MinePage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        items: bottomItem,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
            _pageController.jumpToPage(currentIndex);
          });
        },
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
