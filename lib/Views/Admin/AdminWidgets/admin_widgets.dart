import 'package:dihillah/Custom/Palette.dart';
import 'package:dihillah/Views/Admin/admin_profile_screen.dart';
import 'package:dihillah/Widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AdminWidgets {

  InputDecoration textFieldInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(
        icon,
        color: Palette().maincolor,
      ),
      labelStyle: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Palette().maincolor),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: Palette().maincolor, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Palette().maincolor, width: 1.0),
        borderRadius: BorderRadius.circular(20),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Palette().maincolor, width: 1.0),
        borderRadius: BorderRadius.circular(20),
      ),
      errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15),
    );
  }

  Container adminProfileButton(String label, Color buttonColor) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: buttonColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
          child: Text(label,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold))),
    );
  }

  AppBar adminAppBar(BuildContext context) {
    return AppBar(
      // toolbarHeight: 10,
      elevation: 3,
      automaticallyImplyLeading: false,
      backgroundColor: Palette().maincolor,

      flexibleSpace: Padding(
        padding: const EdgeInsets.only(top: 15,bottom: 5,left: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text('Admin',style: TextStyle(color: Colors.white,fontSize: 20),),
            ),
            Text('Portal',style: TextStyle(color: Colors.white,fontSize: 30),),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 30,right: 20),
          child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AdminProfileScreen()));
              },
              child: Icon(Icons.person, size: 30,)),
        ),

      ],

    );
  }

  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("User"),value: "User"),
      DropdownMenuItem(child: Text("Manager"),value: "Manager"),
    ];
    return menuItems;
  }

Padding usersListView(BuildContext context, String name, String email, String image, GestureDetector gestureDetector){
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Container(
        height: size.height * .12,
        width: size.width,
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade600, width: 1)
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: size.height,
                      width: size.width * .21,
                      decoration: BoxDecoration(
                          // color: Colors.black,
                          borderRadius: BorderRadius.circular(15
                          ),
                        image: DecorationImage(
                          image: NetworkImage(image)
                        )
                      ),
                      ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          email,
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey.shade600),
                        ),


                      ],
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: gestureDetector
              )
            ],
          ),
        ),
      ),
    );
}


}
