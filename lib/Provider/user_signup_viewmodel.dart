import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dihillah/Model/admin_model.dart';
import 'package:dihillah/Model/user_model.dart';
import 'package:dihillah/Views/Admin/show_user_manager_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserSignUpViewModel with ChangeNotifier{

  UserModel userModel = UserModel();

  UserSignUpViewModel() {
    loadLoggedUser();
  }

  Future<void> userSignUp(BuildContext context, {UserModel? userModel}) async {

    try {
      final UserCredential authResult = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: userModel!.email!, password: userModel.password!);

      userModel.id = authResult.user!.uid;

      await userModel.saveInfo();

      await loadLoggedUser(user: authResult.user);

      Navigator.pop(context, false);

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