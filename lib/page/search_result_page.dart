import 'package:flutter/material.dart';
import 'package:wanandroidflutter/api/view_model/search_result_view_model.dart';
import 'package:wanandroidflutter/common/global.dart';
import 'package:wanandroidflutter/util/navigator_util.dart';
import 'package:wanandroidflutter/widget/base/base_widget.dart';
import 'package:wanandroidflutter/widget/base/error_widget.dart';
import 'package:wanandroidflutter/widget/base/loading_widget.dart';
import 'package:wanandroidflutter/widget/common/article_widget.dart';
import 'package:wanandroidflutter/widget/common/line.dart';

class SearchResultPage extends StatefulWidget {
  final String keys;
  SearchResultPage({@required this.keys});
  @override
  _SearchResultPageState createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  SearchResultViewModel _searchResultViewModel = SearchResultViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('${widget.keys}'),
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left),
          onPressed: () {
            NavigatorUtil.maybePop();
          },
        ),
      ),
      body: BaseWidget<SearchResultViewModel>(
        viewModel: _searchResultViewModel,
        onFirstLoading: (v) {
          v.getSearchResultData(key: widget.keys);
        },
        builder: (context, viewModel, child) {
          if (viewModel.getReqStatus == ReqStatus.error) {
            return ErrorWidgetPage();
          }
          if (viewModel.getReqStatus == ReqStatus.loading &&
              viewModel.getSearchResultList.isEmpty) {
            return LoadingWidget();
          } else {
            return ListView.builder(
              itemCount: viewModel.getSearchResultList.length,
              itemBuilder: (context, index) {
                var v = viewModel.getSearchResultList[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ArticleTileWidget(
                      onTap: () => viewModel.searchResultOnTap(
                          title: v.title, url: v.link),
                      title: v?.title,
                      subTitle: v?.shareUser,
                      time: v?.niceDate,
                    ),
                    HorizontalLine(
                      color: Colors.grey.withOpacity(0.8),
                      height: 1,
                    )
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
