import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dihillah/Model/task_model.dart';
import 'package:flutter/material.dart';

class UserManagerViewModel with ChangeNotifier{

  Future<QuerySnapshot<Map<String, dynamic>>> showUsers(){
   final users = FirebaseFirestore.instance.collection("users").where("role", isEqualTo: 'User').get();
    notifyListeners();
    return users;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> showManagers(){
    final managers = FirebaseFirestore.instance.collection("users").where("role", isEqualTo: 'Manager').get();
    notifyListeners();
    return managers;
  }


  assignTask({TaskModel? taskModel}) {
    FirebaseFirestore.instance.collection('task').add(taskModel!.toMap()).catchError((e) {
      print(e.toString());
    });
  }

  Future<QuerySnapshot<Map<String, dynamic>>> showTasks(){
    final tasks = FirebaseFirestore.instance.collection("task").get();
    notifyListeners();
    return tasks;
  }

  String? _userImage;
  String? get userImage => _userImage;

  String getUser(String user) {
    FirebaseFirestore.instance.collection('users').where("userName", isEqualTo: user).get().then((snapshot) async {
      _userImage = await snapshot.docs[0].data()["imageUrl"];
      print("this is userImge $_userImage");
      notifyListeners();
    });
    return _userImage!;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> showPending(){
    final status = FirebaseFirestore.instance.collection("task").where('status', isEqualTo: 'pending').get();
    notifyListeners();
    return status;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> showReview(){
    final status = FirebaseFirestore.instance.collection("task").where('status', isEqualTo: 'review').get();
    notifyListeners();
    return status;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> showInProgress(){
    final status = FirebaseFirestore.instance.collection("task").where('status', isEqualTo: 'inProgress').get();
    notifyListeners();
    return status;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> showComplete(){
    final status = FirebaseFirestore.instance.collection("task").where('status', isEqualTo: 'complete').get();
    notifyListeners();
    return status;
  }

}