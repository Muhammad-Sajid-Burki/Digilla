import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {

  UserModel.fromDocument(DocumentSnapshot<Map<String, dynamic>> documentSnapshot){
    id = documentSnapshot.id;
    role = documentSnapshot.data()!['role'];
    email = documentSnapshot.data()!['email'];
    imageUrl = documentSnapshot.data()!['imageUrl'];
    userName = documentSnapshot.data()!['userName'];
    password = documentSnapshot.data()!['password'];
    phoneNo = documentSnapshot.data()!['phoneNo'];
  }

  String? role;
  String? email;
  String? imageUrl;
  String? userName;
  String? id;
  String? password;
  String? phoneNo;

  UserModel({
    this.role,
    this.email,
    this.imageUrl,
    this.id,
    this.password,
    this.phoneNo,
    this.userName
  });

  DocumentReference get firestoreRef => FirebaseFirestore.instance.doc('users/$id');

  Future<void> saveInfo() async {
    await firestoreRef.set(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'role': role,
      'email': email,
      'imageUrl': imageUrl,
      'userName': userName,
      'password': password,
      'phoneNo': phoneNo,
    };
  }
}