import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'agree.dart';


class Main extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Feed(),
    );
  }
}

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('환자 리스트'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AgreePage()));
              },
              child: Text(
                '마이페이지',
                style: TextStyle(fontSize: 10.0),
              ),
              style: TextButton.styleFrom(
                  primary: Colors.white, backgroundColor: Colors.blue),
            )
          ],
          
        ),
        body: Container(
          child: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('user')
                  .where('isAccepted', isEqualTo: false)
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
                                          padding: const EdgeInsets.all(5.0),
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
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '환자 정보 : ' + collection['birthdate'],
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '증상 : ' + collection['description'],
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '특이사항 : ' + collection['information'],
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ElevatedButton.icon(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => Feed()),
                                            );
                                            FirebaseFirestore.instance
                                                .collection('user')
                                                .doc(collection.id)
                                                .update({'isAccepted': true});
                                          },
                                          icon: const Icon(Icons.check),
                                          label: const Text('수락'),
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
