import 'package:flutter/material.dart';
import 'package:wanandroidflutter/api/view_model/hot_search_view_model.dart';
import 'package:wanandroidflutter/common/global.dart';
import 'package:wanandroidflutter/util/navigator_util.dart';
import 'package:wanandroidflutter/widget/base/base_page.dart';
import 'package:wanandroidflutter/widget/base/base_widget.dart';
import 'package:wanandroidflutter/widget/common/line.dart';
import 'package:wanandroidflutter/widget/common/small_widget.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  HotSearchViewModel _hotSearchViewModel = HotSearchViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Container(
          height: 35.px,
          child: TextField(
            controller: _hotSearchViewModel.getTextController,
            decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(30))),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left),
          onPressed: () {
            NavigatorUtil.maybePop();
          },
        ),
        actions: <Widget>[
          FloatingActionButton(
            heroTag: 'SearchIcon',
            backgroundColor: Colors.transparent,
            child: Icon(Icons.search),
            onPressed: () {
              _hotSearchViewModel.searchOnTap(
                  key: _hotSearchViewModel.getTextController.text);
            },
            elevation: 0,
            shape: RoundedRectangleBorder(),
          ),
        ],
      ),
      body: BasePage<HotSearchViewModel>(
        viewModel: _hotSearchViewModel,
        onFirstLoading: (v) {
          v.getHotSearchData();
        },
        builder: (context, viewModel, child) {
          return BaseWidget(
            reqStatus: viewModel.reqStatus,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SmallWidget(
                    text: '热门搜索',
                    fontColor: Colors.white,
                    bgColor: Colors.blue,
                    fontSize: 18,
                    height: 35.px,
                  ),
                  Wrap(
                    spacing: 25,
                    children: viewModel.getHotSearchList.map((e) {
                      return InkWell(
                        child: Chip(
                          elevation: 4,
                          backgroundColor: Colors.white,
                          label: Text(e.name),
                        ),
                        onTap: () => viewModel.searchOnTap(key: e.name),
                      );
                    }).toList(),
                  ),
                  Visibility(
                      visible: viewModel.getHistorySearchList.isNotEmpty,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: HorizontalLine(
                              height: 0.5,
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              SmallWidget(
                                text: '搜索记录',
                                fontColor: Colors.white,
                                bgColor: Colors.blue,
                                fontSize: 18,
                                height: 35.px,
                              ),
                              Spacer(),
                              SmallWidget(
                                textWidget: IconButton(
                                  icon: Icon(Icons.clear),
                                  onPressed: () =>
                                      viewModel.clearHistorySearch(),
                                ),
                              )
                            ],
                          ),
                          Wrap(
                            spacing: 25,
                            children: viewModel.getHistorySearchList.map((e) {
                              return InkWell(
                                child: Chip(
                                  elevation: 4,
                                  backgroundColor: Colors.white,
                                  label: Text(e),
                                ),
                                onTap: () => viewModel.searchOnTap(key: e),
                              );
                            }).toList(),
                          ),
                        ],
                      ))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}