import 'package:cloud_firestore/cloud_firestore.dart';

class Member{
  final String name;
  final String role;
  final String email;
  final String photo;
  final String department;
  final String birthdate;
  final bool reservation;
  final bool isAccepted;
  final DocumentReference? reference;

  Member.fromMap(Map<String, dynamic>? map,{required this.reference} )
  : name = map?['name'],
    role = map?['role'],
    birthdate = map?['birthdate'],
    email = map?['email'],
    photo = map?['photo'],
    department = map?['department'],
    isAccepted = map?['isAccepted'],
    reservation = map?['reservation'];


  Member.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromMap(snapshot.data() ,reference: snapshot.reference);


  @override
  String toString() => "Member<$name:$role>";


}
