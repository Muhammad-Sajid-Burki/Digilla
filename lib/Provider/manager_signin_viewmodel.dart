import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dihillah/Model/admin_model.dart';
import 'package:dihillah/Model/user_model.dart';
import 'package:dihillah/Views/Admin/show_user_manager_screen.dart';
import 'package:dihillah/Views/manager/create_task_screen.dart';
import 'package:dihillah/Views/manager/manager_main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ManagerSignInViewModel with ChangeNotifier{

  UserModel userModel = UserModel();

  ManagerSignInViewModel() {
    loadLoggedUser();
  }

  Future<void> managerSignIn(BuildContext context, {UserModel? userModel}) async {

    try {
      final UserCredential authResult = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: userModel!.email!, password: userModel.password!);

      await loadLoggedUser(user: authResult.user);

      Navigator.push(context, MaterialPageRoute(builder: (context) => ManagerMainScreen()));


    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${e.toString()}"))
      );
    }
    notifyListeners();
  }

  Future<void> loadLoggedUser({User? user}) async {
    final User currentUser = user ?? FirebaseAuth.instance.currentUser!;
    if(currentUser != null) {
      final DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection('users')
          .doc(currentUser.uid).get();
      userModel = await UserModel.fromDocument(documentSnapshot as DocumentSnapshot<Map<String, dynamic>>);

      notifyListeners();
    }

  }
}