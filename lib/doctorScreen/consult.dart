import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:telemedicine_app1/screens/webviewpage.dart';
import 'package:url_launcher/url_launcher.dart';

class ConsultPage extends StatefulWidget {
  @override
  _ConsultPageState createState() => _ConsultPageState();
}

class _ConsultPageState extends State<ConsultPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('user')
                  .where('isAccepted', isEqualTo: true)
                  .get(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  final List<DocumentSnapshot> documents = snapshot.data!.docs;

                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, index) {
                        DocumentSnapshot collection = snapshot.data!.docs[index];
                        return GestureDetector(
                            onTap: () {},
                            child: Card(
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  collection['name'],
                                                  style: TextStyle(
                                                    fontSize: 21,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  collection['reservation'],
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.green,
                                                  ),
                                                ),
                                              ]))
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '환자 생년월일 : ' + collection['birthdate'],
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '증상 : ' + collection['description'],
                                        style: TextStyle(
                                            fontSize: 11, color: Colors.black),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '특이사항 : ' + collection['information'],
                                        style: TextStyle(
                                            fontSize: 11, color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ElevatedButton.icon(
                                          onPressed: () {
                                            if (kIsWeb) {
                                              goWebView(
                                                  "https://www.mediatelemedicine.tk/sfu/room");
                                            } else {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          WebViewPage()));
                                            }
                                          },
                                          icon: const Icon(Icons.camera),
                                          label: const Text('진료 시작'),
                                        ),
                                      ])
                                ],
                              ),
                            ));
                      });
                }
                return CircularProgressIndicator();
              }),
        ));
  }
}

void goWebView(String url) async {
  if (kIsWeb) {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}