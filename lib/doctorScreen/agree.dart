import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Feed.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';


void goWebView(String url) async {
  if (kIsWeb) {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}

class AgreePage extends StatefulWidget {
  @override
  _AgreePageState createState() => _AgreePageState();
}

class _AgreePageState extends State<AgreePage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('예약 완료 환자 리스트'),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Feed()),
                );
              },
              icon: Icon(Icons.arrow_back),
              iconSize: 20,
              color: Colors.white,
            )),
            
        body: Container(
          child: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('user')
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
                                        '증상 : ' + collection['description'],
                                        style: TextStyle(
                                            fontSize: 11, color: Colors.black),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '특이사항 : ' +
                                            collection['information'] +
                                            collection['birthdate'],
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
                                            goWebView("https://www.mediatelemedicine.tk/sfu/room");
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
