import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wanandroidflutter/util/navigator_util.dart';
import 'package:wanandroidflutter/util/regexp_util.dart';
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

  @override
  void initState() {
    super.initState();
    filterTitle = widget.title;
    if(widget.isHtml){
      filterTitle = filterHtml(widget.title);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(filterTitle,maxLines: 1,overflow: TextOverflow.ellipsis,),
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left),
          onPressed: () => NavigatorUtil.maybePop(),
        ),
      ),
      body: WebView(
        initialUrl: widget.openUrl,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller) {
          _controller.complete(controller);
//          controller.loadUrl(Uri.dataFromString(htmlStr,
//                  mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
//              .toString());
        },
        onPageFinished: (url) {
//          调用js获得实际高度
//          _controller.evaluateJavascript('document.documentElement.clientHeight;').then((value) {
//            setState(() {
//              _height = double.parse(value);
//              print("高度$_height");
//            });
//          });
        },
        navigationDelegate: (NavigationRequest navigation) {
          if (navigation.url.startsWith("myapp://")) {
            print("即将打开 ${navigation.url}");

            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
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
