import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dihillah/Model/admin_model.dart';
import 'package:dihillah/Model/user_model.dart';
import 'package:dihillah/Views/Admin/show_user_manager_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminSignInViewModel with ChangeNotifier{

  AdminModel adminModel = AdminModel();
  notifyListeners();

  AdminSignInViewModel() {
    loadLoggedUser();
  }

  Future<void> adminSignIn(BuildContext context, {AdminModel? adminModel}) async {

    try {
      final UserCredential authResult = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: adminModel!.email!, password: adminModel.password!);

      await loadLoggedUser(user: authResult.user);

      Navigator.push(context, MaterialPageRoute(builder: (context) => ShowUserAndMangerScreen()));


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
      final DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection('admin')
          .doc(currentUser.uid).get();
      adminModel = await AdminModel.fromDocument(documentSnapshot as DocumentSnapshot<Map<String, dynamic>>);

      notifyListeners();
    }

  }
}