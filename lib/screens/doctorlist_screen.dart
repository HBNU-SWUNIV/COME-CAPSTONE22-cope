import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:telemedicine_app1/screens/treatmentstart_screen.dart';


class SearchScreen extends StatefulWidget {
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _filter = TextEditingController();
  FocusNode focusNode = FocusNode();
  String _searchText = "";

  _SearchScreenState() {
    _filter.addListener(() {
      setState(() {
        _searchText = _filter.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('의사 리스트'),
          centerTitle: true,
          
        ),
        body: Container(
          child: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('doctor')
                  .where('isAccepted', isEqualTo: false)
                  .get(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  //final List<DocumentSnapshot> documents = snapshot.data!.docs;

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
                                crossAxisAlignment:CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[]))
                                    ],
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        collection['department'],
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),

                                    ],
                                  ),

                                  SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        collection['name']+' 의사',
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black),
                                      ),
                                      SizedBox(
                                        height: 5,
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
                                                  builder: (context) => TreatmentStart()),
                                            );
                                            FirebaseFirestore.instance
                                                .collection('doctor')
                                                .doc(collection.id)
                                                .update({'isAccepted': true});
                                          },
                                          icon: const Icon(Icons.check),
                                          label: const Text('예약'),
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

  

