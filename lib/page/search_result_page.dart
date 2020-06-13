import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:wanandroidflutter/api/view_model/search_result_view_model.dart';
import 'package:wanandroidflutter/common/global.dart';
import 'package:wanandroidflutter/util/navigator_util.dart';
import 'package:wanandroidflutter/widget/base/base_widget.dart';
import 'package:wanandroidflutter/widget/base/error_widget.dart';
import 'package:wanandroidflutter/widget/base/loading_widget.dart';
import 'package:wanandroidflutter/widget/common/line.dart';
import 'package:html/dom.dart' as dom;

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
                var list = viewModel.getSearchResultList[index];
                return Column(
                  children: <Widget>[
                    InkWell(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                        child: Column(
                          children: <Widget>[
                            Html(
                              data: list.title,
                              customTextStyle:
                                  (dom.Node node, TextStyle baseStyle) {
                                if (node is dom.Element) {
                                  switch (node.localName) {
                                    case "em":
                                      return baseStyle.merge(TextStyle(
                                          color: Colors.red,
                                          height: 1,
                                          fontSize: 18));
                                  }
                                }
                                return baseStyle;
                              },
                              defaultTextStyle: TextStyle(color: Colors.black,fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      onTap: () => viewModel.searchResultOnTap(title: list.title,url: list.link),
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
