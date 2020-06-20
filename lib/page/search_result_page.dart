import 'package:flutter/material.dart';
import 'package:wanandroidflutter/api/view_model/collect_article_view_model.dart';
import 'package:wanandroidflutter/api/view_model/search_result_view_model.dart';
import 'package:wanandroidflutter/model/search_model.dart';
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
        title: Text('${widget.keys}',style: TextStyle(color: Colors.white)),
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
                  SearchModel m = viewModel.getSearchResultList[index];
                  return ArticleTileWidget(
                    onTap: () => viewModel.searchResultOnTap(
                        title: m.title, url: m.link),
                    title: m?.title,
                    subTitle: m?.author,
                    time: m?.niceDate,
                    doCollect: () {
                      m.collect = !m.collect;
                      if (!m.collect) {
                        m.collect = false;
                        return CollectArticleViewModel()
                            .unCollectByHome(articleId: m.id);
                      } else {
                        m.collect = true;
                        return CollectArticleViewModel()
                            .doCollect(articleId: m.id);
                      }
                    },
                    isCollect: m.collect,
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
