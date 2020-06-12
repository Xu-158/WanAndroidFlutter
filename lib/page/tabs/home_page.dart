import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wanandroidflutter/api/view_model/banner_view_model.dart';
import 'package:wanandroidflutter/api/view_model/home_artcile_view_model.dart';
import 'package:wanandroidflutter/common/global.dart';
import 'package:wanandroidflutter/page/search_page.dart';
import 'package:wanandroidflutter/util/navigator_util.dart';
import 'package:wanandroidflutter/widget/base/base_widget.dart';
import 'package:wanandroidflutter/widget/base/error_widget.dart';
import 'package:wanandroidflutter/widget/base/loading_widget.dart';
import 'package:wanandroidflutter/widget/common/line.dart';
import 'package:wanandroidflutter/widget/easyRefresh_widget.dart';

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
      body: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: RefreshWidget(
          controller: _homeArticleViewModel.getEasyRefreshController,
          onRefresh: _homeArticleViewModel.onRefresh,
          onLoad: _homeArticleViewModel.onLoad,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: themeColor,
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
        child: Icon(Icons.search),
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
    return BaseWidget<BannerViewModel>(
      viewModel: viewModel,
      onFirstLoading: (v) {
        v.getBannerData();
      },
      builder: (context, model, child) {
        if (model.getReqStatus == ReqStatus.error) {
          return ErrorWidgetPage();
        }
        if (model.getReqStatus == ReqStatus.loading &&
            model.bannerList.isEmpty) {
          return LoadingWidget();
        } else {
          return Swiper(
            viewportFraction: 0.7,
            scale: 1,
            layout: SwiperLayout.STACK,
            itemWidth: winWidth * 0.90,
            itemHeight: winHeight * 0.28.px,
            itemCount: model.getBannerList.length,
            itemBuilder: (BuildContext context, int index) {
              String url = model.getBannerList[index].imagePath;
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(10),
                ),
                elevation: 10,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(url))),
                ),
              );
            },
            onTap: (index) {
              model.cardOnTap(
                  url: model?.getBannerList[index].url,
                  title: model?.getBannerList[index].title);
            },
          );
        }
      },
    );
  }
}

class ArticleListWidget extends StatelessWidget {
  final HomeArticleViewModel viewModel;
  ArticleListWidget({this.viewModel});

  @override
  Widget build(BuildContext context) {
    return BaseWidget<HomeArticleViewModel>(
      viewModel: viewModel,
      onFirstLoading: (v) {
        v.getHomeArticleData();
      },
      builder: (context, model, child) {
        if (model.getReqStatus == ReqStatus.error) {
          return ErrorWidgetPage();
        }
        if (model.getReqStatus == ReqStatus.loading &&
            model.getArticleList.isEmpty) {
          return LoadingWidget();
        } else {
          return Container(
            decoration: BoxDecoration(
                color: themeColor.withBlue(160),
                borderRadius: BorderRadius.all(
                  Radius.circular(40),
                )),
            padding: EdgeInsets.all(0),
            child: ListView.builder(
              itemCount: model.getArticleList.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return InkWell(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.px, horizontal: 5.px),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(model.getArticleList[index].title,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17),
                                  maxLines: 2),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Visibility(
                              visible:
                                  model?.getArticleList[index]?.author == ''
                                      ? false
                                      : true,
                              child: Text(
                                  'by：${model?.getArticleList[index]?.author}',
                                  style: TextStyle(color: Colors.white)),
                            ),
                            Spacer(),
                            Text(model?.getArticleList[index]?.niceDate,
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                        HorizontalLine(
                          height: 1,
                        ),
                      ],
                    ),
                  ),
                  onTap: () => model.cardOnTap(
                      url: model?.getArticleList[index]?.link,
                      title: model?.getArticleList[index]?.title),
                );
              },
            ),
          );
        }
      },
    );
  }
}
