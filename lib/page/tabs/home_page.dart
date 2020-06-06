import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:wanandroidflutter/api/model/banner_model.dart';
import 'package:wanandroidflutter/api/view_model/banner_view_model.dart';
import 'package:wanandroidflutter/common/global.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int count = 0;
  @override
  void initState() {
    super.initState();
    BannerViewModel(count).getBannerData1();
  }

  BannerViewModel viewModel = BannerViewModel(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider.value(
        value: viewModel,
        child: Column(
          children: <Widget>[
            Consumer<BannerViewModel>(
              builder: (context,model,child){
                if (model.getStatus == ReqStatus.success) {
                  return CustomScrollView(
                    anchor: 0,
                    scrollDirection: Axis.vertical,
                    reverse: false,
                    slivers: <Widget>[mySliverAppBar(model.getList)],
                  );
                } else {
                  return Container(
                    width: 150.px,
                    height: 150.px,
                    color: model.getStatus==ReqStatus.success?Colors.red:Colors.blue,
                    child: Column(
                      children: <Widget>[
                        Text(model.getCount.toString(),style: TextStyle(color: Colors.red,fontSize: 20),),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            model.add();
                            print(model.status);
                            print(model.getCount);
                            print(model.list);
                          },
                        ),
                      ],
                    )
                  );
                }
              },
            ),
          ],
        )
      ),
    );
  }

  Widget mySliverAppBar(List<BannerModel> bannerList) {
    return SliverAppBar(
      expandedHeight: 200,
      flexibleSpace: FlexibleSpaceBar(
        background: Swiper(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            String url = bannerList[index].imagePath;
            print("urlurlurlurl$url");
            return CachedNetworkImage(imageUrl: url);
          },
        ),
      ),
    );
  }
}
