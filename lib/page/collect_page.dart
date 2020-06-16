import 'package:flutter/material.dart';
import 'package:wanandroidflutter/api/view_model/collect_article_view_model.dart';
import 'package:wanandroidflutter/model/collect_articles_model.dart';
import 'package:wanandroidflutter/widget/base/base_Page.dart';
import 'package:wanandroidflutter/widget/base/base_widget.dart';
import 'package:wanandroidflutter/widget/common/article_widget.dart';
import 'package:wanandroidflutter/widget/common/back_button.dart';
import 'package:wanandroidflutter/widget/common/easyRefresh_widget.dart';
import 'package:wanandroidflutter/widget/common/empty_widget.dart';

class CollectPage extends StatefulWidget {
  @override
  _CollectPageState createState() => _CollectPageState();
}

class _CollectPageState extends State<CollectPage> {
  CollectArticleViewModel _collectArticleViewModel = CollectArticleViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的收藏'),
        leading: BackButton1(),
        centerTitle: true,
      ),
      body: BasePage<CollectArticleViewModel>(
        viewModel: _collectArticleViewModel,
        onFirstLoading: (v) {
          v.getCollectArticleListData();
        },
        builder: (context, model, child) {
          return BaseWidget(
            reqStatus: model.getReqStatus,
            child: RefreshWidget(
              controller: model.getEasyRefreshController,
              onRefresh: model.onRefresh,
              onLoad: model.onLoad,
              child: model.getCollectArticleList.length == 0
                  ? EmptyWidget()
                  : ListView.builder(
                      itemCount: model.getCollectArticleList.length,
                      itemBuilder: (context, index) {
                        CollectArticlesModel m = model.getCollectArticleList[index];
                        return ArticleTileWidget(
                          onTap: () => model.cardOnTap(url: m?.link, title: m?.title),
                          title: m?.title,
                          subTitle: m?.author,
                          time: m?.niceDate,
                          doCollect: () {
                            model.unCollectByMine(
                              articleId: m.id,
                              originId: m.originId ?? -1,
                              index: index + 1,
                            );
                          },
                          isCollect: true,
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
