import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AgreePage extends StatefulWidget {
  @override
  _AgreePageState createState() => _AgreePageState();
}

class _AgreePageState extends State<AgreePage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('user')
                  .where('isAccepted', isEqualTo: false)
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
                                      /*Text(
                                        '환자 정보 : ' + collection['birthdate'],
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black),
                                      ),*/
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
                                            dialogPage(context, collection);
                                          },
                                          icon: const Icon(Icons.check),
                                          label: const Text('예약'),
                                        ),
                                        SizedBox(
                                          width: 10,
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

  void dialogPage(context, collection) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('예약하시겠습니까?'),
            actions: <Widget>[
              TextButton(
                child: const Text('확인'),
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection('user')
                      .doc(collection.id)
                      .update({'isAccepted': true});
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: const Text('취소'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
