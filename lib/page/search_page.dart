import 'package:flutter/material.dart';
import 'package:wanandroidflutter/api/view_model/hot_search_view_model.dart';
import 'package:wanandroidflutter/common/global.dart';
import 'package:wanandroidflutter/util/navigator_util.dart';
import 'package:wanandroidflutter/widget/base/base_widget.dart';
import 'package:wanandroidflutter/widget/base/error_widget.dart';
import 'package:wanandroidflutter/widget/base/loading_widget.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  HotSearchViewModel _hotSearchViewModel = HotSearchViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _hotSearchViewModel.getTextController,
          autofocus: true,
          decoration: InputDecoration(
              fillColor: themeColor,
              filled: true,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
        ),
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left),
          onPressed: () {
            NavigatorUtil.maybePop();
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              _hotSearchViewModel.searchOnTap(key: _hotSearchViewModel.getTextController.text);
            },
          ),
        ],
      ),
      body: BaseWidget<HotSearchViewModel>(
        viewModel: _hotSearchViewModel,
        onFirstLoading: (v) {
          v.getHotSearchData();
        },
        builder: (context, viewModel, child) {
          if (viewModel.getReqStatus == ReqStatus.error) {
            return ErrorWidgetPage();
          }
          if (viewModel.getReqStatus == ReqStatus.loading &&
              viewModel.getHotSearchList.isEmpty) {
            return LoadingWidget();
          } else {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Wrap(
                spacing: 20,
                children: viewModel.getHotSearchList.map((e) {
                  return InkWell(
                    child: Chip(
                      elevation: 3,
                      backgroundColor: Colors.white,
                      label: Text(e.name),
                    ),
                    onTap: ()=>viewModel.searchOnTap(key: e.name),
                  );
                }).toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
