import 'package:dihillah/Custom/Palette.dart';
import 'package:dihillah/Provider/admin_signin_viewmodel.dart';
import 'package:dihillah/Views/Admin/AdminWidgets/admin_widgets.dart';
import 'package:dihillah/Widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminProfileScreen extends StatelessWidget {
   AdminProfileScreen({Key? key}) : super(key: key);

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (context) => AdminSignInViewModel(),
      child: Consumer<AdminSignInViewModel>(
        builder: (context, provider, child) {
          print(provider.adminModel.password);
          _emailController.text = provider.adminModel.email!;
          _passwordController.text = provider.adminModel.password!;
          _phoneController.text = provider.adminModel.phoneNo!;
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
            ),
            body: Container(
              color: Colors.white,
              width: size.width,
              height: size.height,
              child: SingleChildScrollView(
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
                              child: CircleAvatar(
                                radius: 80,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 75,
                                  backgroundColor: Colors.grey.shade400,
                                  child: CircleAvatar(
                                    radius: 72,
                                    backgroundImage: NetworkImage(
                                        provider.adminModel.imageUrl.toString()),
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                      child: Column(
                        children: [
                          Text(
                            provider.adminModel.userName.toString().toUpperCase(),
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Palette().fontcolor),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Divider(
                              indent: 40,
                              endIndent: 40,
                              color: Colors.grey.shade500,
                              thickness: 2,
                            ),
                          ),
                          TextFormField(
                            readOnly: true,
                            controller: _emailController,
                            decoration: AdminWidgets().textFieldInputDecoration('Email', Icons.mail),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: TextFormField(
                              readOnly: true,
                              controller: _passwordController,
                              decoration: AdminWidgets().textFieldInputDecoration('Password', Icons.vpn_key),

                            ),
                          ),
                          TextFormField(
                            readOnly: true,
                            controller: _phoneController,
                            decoration: AdminWidgets().textFieldInputDecoration('Phone No', Icons.phone),

                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: AdminWidgets().adminProfileButton('Change Password', Colors.black)
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: AdminWidgets().adminProfileButton('Phase', Colors.red)
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),


                  ],
                ),
              ),
            ),
          );
        }

      ),
    );
  }
}