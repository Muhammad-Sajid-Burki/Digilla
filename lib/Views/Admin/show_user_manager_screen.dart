import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dihillah/Custom/Palette.dart';
import 'package:dihillah/Provider/admin_signin_viewmodel.dart';
import 'package:dihillah/Provider/users_managers_viewmodel.dart';
import 'package:dihillah/Provider/widgets_viewmodel.dart';
import 'package:dihillah/Views/Admin/AdminWidgets/admin_widgets.dart';
import 'package:dihillah/Views/Admin/create_user_manager_screen.dart';
import 'package:dihillah/Views/Admin/update_user_manager_screen.dart';
import 'package:dihillah/Widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ShowUserAndMangerScreen extends StatelessWidget {
  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserManagerViewModel()),
        ChangeNotifierProvider(create: (context) => WidgetsViewModel()),
      ],

        child: Consumer2<UserManagerViewModel, WidgetsViewModel>(
          builder: (context, provider, widgetsProvider, child) => Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(100),
              child: AdminWidgets().adminAppBar(context),
            ),
            body:  Container(
              height: size.height,
              width: size.width,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 10),
                child: SingleChildScrollView(
                  child: Column(children: [
                    // Here, default theme colors are used for activeBgColor, activeFgColor, inactiveBgColor and inactiveFgColor
                    ToggleSwitch(
                      minWidth: size.width * .4,
                      cornerRadius: 20.0,
                      activeBgColors: [
                        [Palette().maincolor],
                        [Palette().maincolor]
                      ],
                      activeFgColor: Colors.white,
                      inactiveBgColor: Colors.grey.shade200,
                      inactiveFgColor: Colors.grey.shade700,
                      fontSize: 20,
                      initialLabelIndex: widgetsProvider.toggleButton,
                      totalSwitches: 2,
                      labels: ['users', 'managers'],
                      radiusStyle: true,
                      onToggle: (index) {
                        print('switched to: $index');
                        widgetsProvider.setToggleButton(index!);
                      },
                    ),
                    Container(
                      height: size.height * .5,
                      width: size.width,
                      child: widgetsProvider.circular ? Center(child: CircularProgressIndicator()) :  StreamBuilder<QuerySnapshot>(
                        stream: widgetsProvider.toggleButton == 0 ? provider.showUsers().asStream() : provider.showManagers().asStream(),
                        builder: (context, snapshot) {
                          return (snapshot.connectionState ==
                                      ConnectionState.waiting &&
                                  snapshot.data == null)
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : ListView.builder(
                                  controller: controller,
                                  itemCount: snapshot.data?.docs.length,
                                  itemBuilder: (context, index) {
                                    DocumentSnapshot data =
                                        snapshot.data!.docs[index];

                                    return AdminWidgets().usersListView(
                                        context,
                                        data['userName'],
                                        data['email'],
                                        data['imageUrl'],
                                      GestureDetector(
                                        onTap: () {
                                          widgetsProvider.setCircular(true);
                                          FirebaseAuth.instance
                                              .signInWithEmailAndPassword(
                                              email: data['email'],
                                              password: data['password'])
                                              .then((userCredential) async {
                                            await FirebaseFirestore.instance
                                                .collection("users")
                                                .doc(userCredential.user!.uid).delete();
                                            userCredential.user!.delete();
                                            widgetsProvider.setCircular(false);


                                          }).catchError((error) {
                                            print("Error " + error.toString());
                                          });
                                        },
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Icon(Icons.delete),
                                            Text('Delete')
                                          ],
                                        ),
                                      ),

                                    );

                                  });
                        },
                      ),
                    ),
                    SizedBox(
                      height: size.height * .10,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CreateUserManagerScreen()));
                        },
                        child: CustomWidgets().iconButton(
                            context, Icons.person, 'Add User/Manager')),
                    SizedBox(
                      height: 15,
                    ),
                  ]),
                ),
              ),
            ),
          ),
        ),
    );
  }
}
