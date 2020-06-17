import 'package:flutter/material.dart';
import 'package:wanandroidflutter/api/view_model/collect_article_view_model.dart';
import 'package:wanandroidflutter/api/view_model/search_result_view_model.dart';
import 'package:wanandroidflutter/widget/base/base_Page.dart';
import 'package:wanandroidflutter/widget/base/base_widget.dart';
import 'package:wanandroidflutter/widget/common/article_widget.dart';
import 'package:wanandroidflutter/widget/common/back_button.dart';
import 'package:wanandroidflutter/widget/common/easyRefresh_widget.dart';

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
        leading: BackButton1(),
      ),
      body: BasePage<SearchResultViewModel>(
        viewModel: _searchResultViewModel,
        onFirstLoading: (v) {
          v.getSearchResultData(key: widget.keys);
        },
        builder: (context, viewModel, child) {
          return BaseWidget(
            reqStatus: viewModel.reqStatus,
            child: RefreshWidget(
              controller: viewModel.getEasyRefreshController,
              onRefresh: viewModel.onRefresh,
              onLoad: viewModel.onLoad,
              child: ListView.builder(
                itemCount: viewModel.getSearchResultList.length,
                itemBuilder: (context, index) {
                  var v = viewModel.getSearchResultList[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ArticleTileWidget(
                        onTap: () => viewModel.searchResultOnTap(title: v.title, url: v.link),
                        title: v?.title,
                        subTitle: v?.shareUser,
                        time: v?.niceDate,
                        doCollect: () {
                          v.collect = !v.collect;
                          if(v.collect){
                            return CollectArticleViewModel().unCollectByHome(articleId: v.id);
                          }else{
                            return CollectArticleViewModel().doCollect(articleId: v.id);
                          }
                        },
                        isCollect: v.collect,
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
