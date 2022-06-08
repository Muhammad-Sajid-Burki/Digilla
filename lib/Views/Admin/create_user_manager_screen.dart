import 'package:dihillah/Custom/Palette.dart';
import 'package:dihillah/Model/user_model.dart';
import 'package:dihillah/Provider/user_signup_viewmodel.dart';
import 'package:dihillah/Provider/widgets_viewmodel.dart';
import 'package:dihillah/Views/Admin/AdminWidgets/admin_widgets.dart';
import 'package:dihillah/Widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateUserManagerScreen extends StatelessWidget {
  CreateUserManagerScreen({Key? key}) : super(key: key);

  TextEditingController _userNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => WidgetsViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserSignUpViewModel(),
        ),
      ],
      child: Consumer2<WidgetsViewModel, UserSignUpViewModel>(
        builder: (context, widgetProvider, signUpProvider, child) => Scaffold(
          appBar: AppBar(
            backgroundColor: Palette().maincolor,
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
                    GestureDetector(
                      onTap: () {
                        widgetProvider.selectGalleryImage();
                      },
                      child: Container(
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
                                      backgroundColor: Palette().maincolor,
                                      radius: 72,
                                      backgroundImage:
                                          widgetProvider.imageFile == null
                                              ? null
                                              : FileImage(
                                                  widgetProvider.imageFile!),
                                      child: widgetProvider.imageFile == null
                                          ? Icon(
                                              Icons.person,
                                              size: 100,
                                              color: Colors.white70,
                                            )
                                          : null,
                                    ),
                                  ),
                                ))
                          ],
                        ),
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
                            onChanged: (val) {
                              _phoneController.text = val;
                              print(_phoneController.text);
                            },
                            decoration: AdminWidgets().textFieldInputDecoration(
                                'Phone No', Icons.phone),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Container(
                              padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                              height: MediaQuery.of(context).size.height * .075,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Palette().maincolor),
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.person,
                                    color: Palette().maincolor,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Container(
                                      width: size.width * .65,
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          iconEnabledColor: Palette().maincolor,
                                          iconDisabledColor:
                                              Palette().fontcolor,
                                          isExpanded: true,
                                          value: widgetProvider.userManager,
                                          items: AdminWidgets().dropdownItems,
                                          onChanged: (value) {
                                            widgetProvider.setUserManager(
                                                value.toString());
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(top: 40),
                              child: GestureDetector(
                                  onTap: () async {
                                    if (_formKey.currentState!.validate()) {
                                      widgetProvider.setCircular(true);
                                      await widgetProvider.uploadImage(context);
                                      signUpProvider.userSignUp(context,
                                          userModel: UserModel(
                                              role: widgetProvider.userManager,
                                              email:
                                                  _emailController.text.trim(),
                                              imageUrl: widgetProvider
                                                  .imageUrlDownload,
                                              password: _passwordController.text
                                                  .trim(),
                                              phoneNo:
                                                  _phoneController.text.trim(),
                                              userName: _userNameController.text
                                                  .trim()));
                                      widgetProvider.setCircular(false);
                                    }
                                  },
                                  child: widgetProvider.circular ? CircularProgressIndicator(
                              valueColor:AlwaysStoppedAnimation<Color>(Palette().fontcolor))
                    :
                                  CustomWidgets().iconButton(
                                      context,
                                      Icons.person_add_alt_1_outlined,
                                      "Add ${widgetProvider.userManager}")))
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
