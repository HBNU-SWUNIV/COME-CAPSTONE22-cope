import 'package:cloud_firestore/cloud_firestore.dart';

class Member{
  final String name;
  final String role;
  final String email;
  final String photo;
  final bool reservation;
  final DocumentReference? reference;

  Member.fromMap(Map<String, dynamic> map,{this.reference} )
  : name = map['name'],
    role = map['role'],
    email = map['email'],
    photo = map['photo'],
    reservation = map['reservation'];


  Member.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>, reference: snapshot.reference);


  @override
  String toString() => "Member<$name:$role>";


}
