import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dihillah/Custom/Palette.dart';
import 'package:dihillah/Model/user_model.dart';
import 'package:dihillah/Provider/user_signup_viewmodel.dart';
import 'package:dihillah/Provider/widgets_viewmodel.dart';
import 'package:dihillah/Views/Admin/AdminWidgets/admin_widgets.dart';
import 'package:dihillah/Widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateUserManagerScreen extends StatelessWidget {
  UpdateUserManagerScreen({Key? key, required this.data}) : super(key: key);

  DocumentSnapshot? data;

  TextEditingController _userNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    _userNameController.text = data!['userName'];
    _emailController.text = data!['email'];
    _passwordController.text = data!['password'];
    _phoneController.text = data!['phoneNo'];

    return ChangeNotifierProvider(
          create: (context) => WidgetsViewModel(),
      child: Consumer<WidgetsViewModel>(
        builder: (context, widgetProvider, child) => Scaffold(
          appBar: AppBar(
            elevation: 0,
          ),
          body: Container(
            color: Colors.white,
            width: size.width,
            height: size.height,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: size.height * .3,
                      width: size.width,
                      decoration: BoxDecoration(color: Colors.white),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: size.height * .2,
                              width: size.width,
                              decoration:
                                  BoxDecoration(color: Palette().maincolor),
                            ),
                          ),
                          Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  widgetProvider.selectGalleryImage();
                                },
                                child: CircleAvatar(
                                  radius: 80,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    radius: 75,
                                    backgroundColor: Colors.grey.shade400,
                                    child: widgetProvider.imageFile == null
                                        ? CircleAvatar(
                                            backgroundColor:
                                                Palette().maincolor,
                                            radius: 72,
                                            backgroundImage:
                                                NetworkImage(data!['imageUrl']))
                                        : CircleAvatar(
                                            backgroundColor:
                                                Palette().maincolor,
                                            radius: 72,
                                            backgroundImage: FileImage(
                                                widgetProvider.imageFile!),
                                          ),
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 30),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: TextFormField(
                              controller: _userNameController,
                              onChanged: (val) {
                                _userNameController.text = val;
                                print(_userNameController.text);
                              },
                              decoration: AdminWidgets()
                                  .textFieldInputDecoration(
                                      'UserName', Icons.person),
                            ),
                          ),
                          TextFormField(
                            controller: _emailController,
                            onChanged: (val) {
                              _emailController.text = val;
                              print(_emailController.text);
                            },
                            decoration: AdminWidgets()
                                .textFieldInputDecoration('Email', Icons.mail),
                            validator: (val) {
                              return RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(val!)
                                  ? null
                                  : "please provide a valid email address";
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: TextFormField(
                              controller: _passwordController,
                              decoration: AdminWidgets()
                                  .textFieldInputDecoration(
                                      'Password', Icons.vpn_key),
                              onChanged: (val) {
                                _passwordController.text = val;
                                print(_passwordController.text);
                              },
                              validator: (val) {
                                return val!.length > 6
                                    ? null
                                    : "please provide password 6+ character";
                              },
                            ),
                          ),
                          TextFormField(
                            controller: _phoneController,
                            onChanged: (val) {
                              _phoneController.text = val;
                              print(_phoneController.text);
                            },
                            decoration: AdminWidgets().textFieldInputDecoration(
                                'Phone No', Icons.phone),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(top: 40),
                              child: GestureDetector(
                                  onTap: () async {
                                    if (_formKey.currentState!.validate()) {
                                      if (widgetProvider.imageFile != null){
                                        await widgetProvider.uploadImage(context);
                                      }
                                      // Create a credential
                                      AuthCredential credential = EmailAuthProvider.credential(email: _emailController.text.trim(), password: _passwordController.text.trim());
                                      await FirebaseAuth.instance.currentUser!.reauthenticateWithCredential(credential);
                                      FirebaseAuth.instance
                                          .signInWithEmailAndPassword(
                                              email: data!['email'],
                                              password: data!['password'])
                                          .then((userCredential) {
                                        userCredential.user!.delete();
                                        FirebaseFirestore.instance
                                            .collection("users")
                                            .doc(userCredential.user!.uid)
                                            .update({
                                          "email":
                                          _emailController.text.trim(),
                                          "imageUrl": widgetProvider.imageUrlDownload == null ? data!['imageUrl'] : widgetProvider.imageUrlDownload,
                                          "userName":
                                        _userNameController.text.trim(),
                                          "password":
                                              _passwordController.text.trim(),
                                          "phoneNo":
                                          _phoneController.text.trim(),
                                          "role":
                                          data!['role'],
                                        }).then((_) {
                                          print(
                                              "Successfully changed password");
                                        });
                                      }).catchError((error) {
                                        print("Error " + error.toString());
                                      });
                                    }
                                  },
                                  child: CustomWidgets().iconButton(context,
                                      Icons.update, "Update ${data!['role']}")))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
