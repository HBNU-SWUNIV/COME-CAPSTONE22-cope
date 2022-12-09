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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('화상 진료'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
                width:400,
                height:650,
                child: InAppWebView(
                  initialUrlRequest: URLRequest(url: Uri.parse("https://www.mediatelemedicine.tk/sfu/room")),
                )
            ),
            OutlinedButton(
              child: Text(
                '진료기기 사용안내',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blue,
                ),
              ),
              onPressed: () => FlutterDialog(),
            ),

          ],
        ),
        )
    );
  }

  void FlutterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context){
      return AlertDialog(
        backgroundColor: Colors.white,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "내용",),
          ],
        ),
      );
      });
  }
}