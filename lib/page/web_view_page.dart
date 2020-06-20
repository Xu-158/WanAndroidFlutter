import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
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

  @override
  void initState() {
    super.initState();
    filterTitle = widget.title;
    if(widget.isHtml){
      filterTitle = filterHtml(widget.title);
    }
  }


  void _openApp(openurl) async{
    Uri uri = Uri.parse(openurl);
    var scheme;
    switch (uri.host) {
      case 'www.jianshu.com': //简书
        scheme = 'jianshu://${uri.pathSegments.join("/")}';
        break;
      case 'juejin.im': //掘金
      /// 原始链接:https://juejin.im/post/5d66565cf265da03e71b0672
      /// App链接:juejin://post/5d66565cf265da03e71b0672
        scheme = 'juejin://${uri.pathSegments.join("/")}';
        break;
      default:
        break;
    }
    if (await canLaunch(scheme)) {
      return scheme;
    } else {
      throw 'Could not launch $openurl';
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(filterTitle,maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white),),
        leading: BackButton1(),
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
        navigationDelegate: (NavigationRequest request) {
          if (request.url.startsWith('js://webview')) {
            print('blocking navigation to $request}');
            _openApp(request.url.replaceAll("js://webview", "").replaceAll("?url=", ""));
            return NavigationDecision.prevent;
          }
          print('allowing navigation to $request');
          return NavigationDecision.navigate;
//          ///通过拦截url来实现js与flutter交互
//          if (navigation.url.startsWith('js://webview')) {
//            showToast(message:'JS调用了Flutter By navigationDelegate');
//            print('blocking navigation to $navigation}');
//            return NavigationDecision.prevent;///阻止路由替换，不能跳转，因为这是js交互给我们发送的消息
//          }
//          return NavigationDecision.navigate;///允许路由替换
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
