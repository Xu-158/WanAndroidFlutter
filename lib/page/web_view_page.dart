import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:html/dom.dart' as dom;

class WebViewPage extends StatefulWidget {
  final String openUrl;
  final String title;
  final bool isHtml;
  WebViewPage(
      {this.openUrl = 'https://flutterchina.club/',
      this.title = "WebView",
      this.isHtml});
  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.isHtml
            ? Html(
                data: widget.title,
                customTextStyle: (dom.Node node, TextStyle baseStyle) {
                  if (node is dom.Element) {
                    switch (node.localName) {
                      case "em":
                        return baseStyle.merge(TextStyle(
                            color: Colors.white, height: 1, fontSize: 18));
                    }
                  }
                  return baseStyle;
                },
                defaultTextStyle: TextStyle(color: Colors.white, fontSize: 18),
              )
            : Text(widget.title),
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
