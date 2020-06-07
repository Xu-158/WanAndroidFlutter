import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wanandroidflutter/api/model/banner_model.dart';
import 'package:wanandroidflutter/api/view_model/banner_view_model.dart';
import 'package:wanandroidflutter/common/global.dart';
import 'package:wanandroidflutter/widget/base_widget.dart';
import 'package:wanandroidflutter/widget/loading_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  BannerViewModel viewModel = BannerViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseWidget(
        viewModel: viewModel,
        builder: (context, model, child) {
          if (model.getReqStatus == ReqStatus.success) {
            return CustomScrollView(
              scrollDirection: Axis.vertical,
              reverse: false,
              slivers: <Widget>[mySliverAppBar(model.getList)],
            );
          } else {
            model.getBannerData();
            return LoadingWidget();
          }
        },
      ),
    );
  }

  Widget mySliverAppBar(List<BannerModel> bannerList) {
    return SliverAppBar(
      expandedHeight: 200,
      backgroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        background: Swiper(
          viewportFraction: 1,
          scale: 0.8,
          autoplay: true,
          itemCount: bannerList.length,
          itemBuilder: (BuildContext context, int index) {
            String url = bannerList[index].imagePath;
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
      ),
    );
  }
}
