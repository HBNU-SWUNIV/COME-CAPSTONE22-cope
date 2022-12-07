
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class WebViewPage extends StatefulWidget {

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {

  @override
  void initState() {
    super.initState();
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
      body: Center (
        child: ElevatedButton(
          onPressed: () {

              goWebView("https://www.mediatelemedicine.tk/sfu/room");
          },
          child: Text("Button"),
        ),
      )
  );
}
}

void goWebView(String url) async {
  await launch(url);
  }




