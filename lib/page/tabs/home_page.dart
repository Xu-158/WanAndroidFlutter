import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wanandroidflutter/api/view_model/home_view_model.dart';
import 'package:wanandroidflutter/common/global.dart';
import 'package:wanandroidflutter/page/web_view_page.dart';
import 'package:wanandroidflutter/widget/base_widget.dart';
import 'package:wanandroidflutter/widget/loading_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        body: ListView(
          children: <Widget>[
            BannerWidget(),
            ArticleListWidget(),
          ],
        ));
  }

  @override
  bool get wantKeepAlive => true;
}

class BannerWidget extends StatelessWidget {
  final HomeViewModel viewModel = HomeViewModel();

  @override
  Widget build(BuildContext context) {
    return BaseWidget<HomeViewModel>(
      viewModel: viewModel,
      onLoading: (v) {
        v.getBannerData();
      },
      builder: (context, model, child) {
        if (model.reqStatus == ReqStatus.success) {
          return Container(
            height: winHeight * 0.3,
            child: Swiper(
              viewportFraction: 1,
              scale: 0.8,
              autoplay: true,
              itemCount: model.getBannerList.length,
              itemBuilder: (BuildContext context, int index) {
                String url = model.getBannerList[index].imagePath;
                return Card(
                  elevation: 5,
                  child: CachedNetworkImage(
                    imageUrl: url,
                    fit: BoxFit.fill,
                  ),
                );
              },
              onTap: (index) {},
            ),
          );
        } else {
          return LoadingWidget();
        }
      },
    );
  }
}

class ArticleListWidget extends StatelessWidget {
  final HomeViewModel viewModel = HomeViewModel();

  @override
  Widget build(BuildContext context) {
    return BaseWidget<HomeViewModel>(
      viewModel: viewModel,
      onLoading: (v) {
        v.getHomeArticleData();
      },
      builder: (context, model, child) {
        if (model.reqStatus == ReqStatus.success) {
          return ListView.builder(
            itemCount: model.getArticleList.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return InkWell(
                child: Card(
                  color: Colors.blueGrey,
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.px, horizontal: 10.px),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(model.getArticleList[index].title,
                                  style: TextStyle(color: Colors.white, fontSize: 16), maxLines: 2),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Visibility(
                              visible: model?.getArticleList[index]?.author == '' ? false : true,
                              child: Text('作者：${model?.getArticleList[index]?.author}',
                                  style: TextStyle(color: Colors.white)),
                            ),
                            Spacer(),
                            Text(model?.getArticleList[index]?.niceDate,
                                style: TextStyle(color: Colors.white)),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context){
                      String _tilte =  (model?.getArticleList[index]?.title).toString();
                      return WebViewPage(openUrl: model?.getArticleList[index]?.link,title: _tilte,);
                    }
                  ));
                },
              );
            },
          );
        } else {
          return LoadingWidget();
        }
      },
    );
  }
}
