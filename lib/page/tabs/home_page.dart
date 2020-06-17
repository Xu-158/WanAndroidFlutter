import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wanandroidflutter/api/view_model/banner_view_model.dart';
import 'package:wanandroidflutter/api/view_model/collect_article_view_model.dart';
import 'package:wanandroidflutter/api/view_model/home_artcile_view_model.dart';
import 'package:wanandroidflutter/common/global.dart';
import 'package:wanandroidflutter/model/home_article_model.dart';
import 'package:wanandroidflutter/page/search_page.dart';
import 'package:wanandroidflutter/util/navigator_util.dart';
import 'package:wanandroidflutter/widget/base/base_page.dart';
import 'package:wanandroidflutter/widget/base/base_widget.dart';
import 'package:wanandroidflutter/widget/common/article_widget.dart';
import 'package:wanandroidflutter/widget/common/easyRefresh_widget.dart';
import 'package:wanandroidflutter/widget/common/place_holder_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  final BannerViewModel _bannerViewModel = BannerViewModel();
  final HomeArticleViewModel _homeArticleViewModel = HomeArticleViewModel();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SafeArea(
        child: RefreshWidget(
          controller: _homeArticleViewModel.getEasyRefreshController,
          onRefresh: _homeArticleViewModel.onRefresh,
          onLoad: _homeArticleViewModel.onLoad,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Colors.white,
                expandedHeight: 200.px,
                flexibleSpace: FlexibleSpaceBar(
                  background: BannerWidget(viewModel: _bannerViewModel),
                ),
              ),
              SliverToBoxAdapter(
                  child: ArticleListWidget(viewModel: _homeArticleViewModel)),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: themeColor,
        foregroundColor: Colors.white,
        heroTag: 'SearchIcon',
        child: Icon(Icons.search, size: 28.px),
        onPressed: () {
          NavigatorUtil.push(SearchPage());
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class BannerWidget extends StatelessWidget {
  final BannerViewModel viewModel;
  BannerWidget({this.viewModel});

  @override
  Widget build(BuildContext context) {
    return BasePage<BannerViewModel>(
      viewModel: viewModel,
      onFirstLoading: (v) {
        v.getBannerData();
      },
      builder: (context, model, child) {
        return BaseWidget(
            reqStatus: model.reqStatus,
            child: AspectRatio(
              aspectRatio: 16.0 / 9.0,
              child: Swiper(
                viewportFraction: 0.8,
                scale: 0.9,
                layout: SwiperLayout.DEFAULT,
                itemCount: model.getBannerList.length,
                itemBuilder: (BuildContext context, int index) {
                  String url = model.getBannerList[index].imagePath;
                  return Card(
                    elevation: 10,
                    child: CachedNetworkImage(
                      imageUrl: url,
                      placeholder: (context, url) => PlaceHolderWidget(),
                      fit: BoxFit.fill,
                    ),
                  );
                },
                onTap: (index) {
                  model.cardOnTap(
                      url: model?.getBannerList[index].url,
                      title: model?.getBannerList[index].title);
                },
              ),
            ));
      },
    );
  }
}

class ArticleListWidget extends StatelessWidget {
  final HomeArticleViewModel viewModel;
  ArticleListWidget({this.viewModel});

  @override
  Widget build(BuildContext context) {
    return BasePage<HomeArticleViewModel>(
      viewModel: viewModel,
      onFirstLoading: (v) {
        v.getHomeArticleData();
      },
      builder: (context, model, child) {
        return BaseWidget(
          reqStatus: model.reqStatus,
          child: ListView.builder(
            itemCount: model.getArticleList.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              HomeArticleModel m = model.getArticleList[index];
              return ArticleTileWidget(
                onTap: () => model.cardOnTap(url: m?.link, title: m?.title),
                title: m?.title,
                subTitle: m?.shareUser,
                time: m?.niceDate,
                doCollect: () {
                  m.collect = !m.collect;
                  if(!m.collect){
                    return CollectArticleViewModel().unCollectByHome(articleId: m.id);
                  }else{
                    return CollectArticleViewModel().doCollect(articleId: m.id);
                  }
                },
                isCollect: m.collect,
              );
            },
          ),
        );
      },
    );
  }
}
