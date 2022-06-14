import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
class WebViewPage extends StatefulWidget {
  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'WebView',
        )
      ),
      body: Container(
        child: InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse("https://www.mediatelemedicine.tk/sfu/room")),
          )
      )
    );
  }
}