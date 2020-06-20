import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:wanandroidflutter/util/OpenAppUtils.dart';
import 'package:wanandroidflutter/util/regexp_util.dart';
import 'package:wanandroidflutter/widget/common/back_button.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String openUrl;

  final String title;

// 标题是否包含HTML标签
  final bool isHtml;

  WebViewPage(
      {this.openUrl = 'https://flutterchina.club/',
      this.title = "WebView",
      this.isHtml = false});
  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  String filterTitle;

  Future canOpenAppFuture;

  @override
  void initState() {
    super.initState();
    filterTitle = widget.title;
    if (widget.isHtml) {
      filterTitle = filterHtml(widget.title);
    }
    canOpenAppFuture = OpenAppUtils.canOpenApp(widget.openUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          filterTitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.white),
        ),
        leading: BackButton1(),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: InkWell(
              child: Icon(Icons.share,color: Colors.white,),
              onTap: (){
                Share.share('我正在看${widget.title},地址是${widget.openUrl}');
              },
            ),
          )
        ],
      ),
      body: WebView(
        initialUrl: widget.openUrl,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller) {
          _controller.complete(controller);
        },
        navigationDelegate: (NavigationRequest request)async {
          debugPrint('导航$request');
          if (!request.url.startsWith('http')) {
            OpenAppUtils.openAppByUrl(request.url);
            return NavigationDecision.prevent;
          } else {
            return NavigationDecision.navigate;
          }
        },
        javascriptChannels: <JavascriptChannel>[
          JavascriptChannel(
              name: "xxx",
              onMessageReceived: (JavascriptMessage message) {
                print("参数： ${message.message}");
              })
        ].toSet(),
      ),
    );
  }
}
