import 'package:dihillah/Custom/Palette.dart';
import 'package:dihillah/Views/Admin/admin_login_screen.dart';
import 'package:dihillah/Views/manager/manager_home_screen.dart';
import 'package:dihillah/Views/manager/manager_login_screen.dart';
import 'package:dihillah/Views/manager/all_users_messages_screen.dart';
import 'package:dihillah/Views/manager/manager_main_screen.dart';
import 'package:dihillah/Views/manager/progress_task_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
     title: 'Flutter Demo',
     theme: ThemeData(
       primarySwatch: Palette.mainColor,
     ),
     home: ManagerLoginScreen(),
    );
  }
}
