import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:telemedicine_app1/screens/webviewpage.dart';
import 'package:url_launcher/url_launcher.dart';



class TreatmentStart extends StatefulWidget {
  @override
  _TreatmentStartState createState() => _TreatmentStartState();
}

class _TreatmentStartState extends State<TreatmentStart> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;


void goWebView(String url) async {
  if (kIsWeb) {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('진료 예약 의사 리스트'),
          centerTitle: true,

        ),
        body: Container(
          child: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('doctor')
                  .where('isAccepted', isEqualTo: true)
                  .get(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  // final List<DocumentSnapshot> documents = snapshot.data!.docs;

                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, index) {
                        DocumentSnapshot collection =
                            snapshot.data!.docs[index];
                        return GestureDetector(
                            onTap: () {
                              //Navigator.of(context).push(MaterialPageRoute(builder:(BuildContext context) => DetailPage(collection)));
                            },
                            child: Card(
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                              crossAxisAlignment:CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  collection['name'] + (' 의사'),
                                                  style: TextStyle(
                                                    fontSize: 21,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  collection['department'],
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  ('진료예약시간 : ')+collection['reservation'],
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.green,
                                                  ),
                                                ),
                                              ]))
                                    ],
                                  ),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ElevatedButton.icon(
                                          onPressed: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewPage()));
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