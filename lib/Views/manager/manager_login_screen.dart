import 'package:dihillah/Custom/Palette.dart';
import 'package:dihillah/Model/admin_model.dart';
import 'package:dihillah/Model/user_model.dart';
import 'package:dihillah/Provider/admin_signin_viewmodel.dart';
import 'package:dihillah/Provider/manager_signin_viewmodel.dart';
import 'package:dihillah/Views/Admin/admin_login_screen.dart';
import 'package:dihillah/Views/manager/create_task_screen.dart';
import 'package:dihillah/Widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManagerLoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ManagerSignInViewModel(),
      child: Consumer<ManagerSignInViewModel>(
        builder: (context, provider, child) =>
            SafeArea(
              child: Scaffold(
                backgroundColor: Colors.white,
                body: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 70, 30, 8),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundImage: AssetImage('assets/logo.png'),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Welcome',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                          Text(
                            'Manager',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Palette().maincolor,
                            ),
                          ),
                          Text(
                            'Login back into your account',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            'Username',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 20.0),
                            child: TextFormField(
                              controller: _userNameController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey.shade200,
                                  hintText: 'Type your username',
                                  labelText: 'UserName',
                                  // contentPadding: EdgeInsets.all(16.0),
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Colors.grey,
                                  )),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter email';
                                }
                                return null;
                              },
                            ),
                          ),
                          Text(
                            'Password',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 20.0),
                            child: TextFormField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey.shade200,
                                  hintText: 'Type your Password',
                                  labelText: 'Password',
                                  // contentPadding: EdgeInsets.all(16.0),
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.grey,
                                  )),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter password';
                                }
                                return null;
                              },
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => AdminLoginScreen()), (route) => false);
                              },
                              child: Text(
                                'Login Admin >>',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (_formKey.currentState!.validate())  {
                                provider.managerSignIn(context,userModel: UserModel(email: _userNameController.text.trim(),password: _passwordController.text.trim()));
                                print("userName of admin is ${provider.userModel.userName}");

                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Palette().maincolor,
                                // border: Border.all(color: Colors.grey.shade600),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              child: Center(
                                  child: Text('Login',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 23,
                                          fontWeight: FontWeight.bold))),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
      ),
    );
  }
}
