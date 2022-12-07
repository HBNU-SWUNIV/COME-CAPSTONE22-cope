import 'package:cloud_firestore/cloud_firestore.dart';

class Member{
  final String name;
  final String email;
  final String department;
  final String birthdate;
  final String content1;
  final String content2;
  final bool reservation;
  final bool isAccepted;
  final bool isDoctor;
  final String prescription;
  final DocumentReference? reference;

  Member.fromMap(Map<String, dynamic>? map,{required this.reference} )
  : name = map?['name'],
    birthdate = map?['birthdate'],
    email = map?['email'],
    department = map?['department'],
    isAccepted = map?['isAccepted'],
    isDoctor = map?['isDoctor'],
    content1 = map?['content1'],
    content2 = map?['content2'],
    reservation = map?['reservation'],
    prescription = map?['prescription'];


  Member.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromMap(snapshot.data() ,reference: snapshot.reference);


  @override
  String toString() => "Member<$name:$isDoctor>";


}
