import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ConsultPage extends StatefulWidget {
  @override
  _ConsultPageState createState() => _ConsultPageState();
}

class _ConsultPageState extends State<ConsultPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController contentcontroller = TextEditingController();
  String inputs = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('진료화면'),
          centerTitle: true,
        ),
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
                          onTap: () {},
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                        width: 0.5,
                                        color: Colors.black,
                                      )),
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.4,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                        width: 0.5,
                                        color: Colors.black,
                                      )),
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.4,
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                      width: 0.5,
                                      color: Colors.black,
                                    )),
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    height: MediaQuery.of(context).size.height *
                                        0.8,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      PrescriptionPage(context, collection);
                                    },
                                    icon: const Icon(Icons.check_circle),
                                    label: const Text('진료 완료'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      });
                }
                return CircularProgressIndicator();
              }),
        ));
  }

  void PrescriptionPage(context, collection) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Column(
                    children: [
                      Text(
                        collection['name'],
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text(
                        collection['reservation'],
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.green,
                        ),
                      ),
                      Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                            width: 0.5,
                            color: Colors.black,
                          )),
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: MediaQuery.of(context).size.width * 0.5,
                          child: TextField(
                            style: TextStyle(fontSize: 20, color: Colors.black),
                            textAlign: TextAlign.center,
                            maxLines: 30,
                            onChanged: (String str) {
                              setState(() => inputs);
                            },
                          )),
                      SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () {
                          /*Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AgreePage()),
                          );*/
                          FirebaseFirestore.instance
                              .collection('user')
                              .doc(collection.id)
                              .update({'prescription': inputs});
                        },
                        icon: Icon(Icons.check),
                        label: Text('저장'),
                      ),
                    ],
                  )));
        });
  }
}
