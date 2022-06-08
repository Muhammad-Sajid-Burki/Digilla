import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dihillah/Custom/Palette.dart';
import 'package:dihillah/Provider/users_managers_viewmodel.dart';
import 'package:dihillah/Provider/widgets_viewmodel.dart';
import 'package:dihillah/Views/manager/ManagerWidgets/manager_widgets.dart';
import 'package:dihillah/Views/manager/create_task_screen.dart';
import 'package:dihillah/Views/manager/progress_task_screen.dart';
import 'package:dihillah/Widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:provider/provider.dart';

class ManagerHomeScreen extends StatelessWidget {
  ManagerHomeScreen({Key? key}) : super(key: key);

  late Animation<double> animation;
  late CurvedAnimation curve;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return
        ChangeNotifierProvider(create: (context) => UserManagerViewModel(),

      child: Consumer<UserManagerViewModel>(
        builder: (context,userProvider, child) => Scaffold(
          body: Container(
            width: size.width,
            height: size.height,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 30, 30, 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hi",
                      style: TextStyle(
                          color: Palette().fontcolor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Manager",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    Text('You have 6 task\n to review',
                        style: TextStyle(
                            color: Palette().fontcolor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Progresstask()));
                      },
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.grey.shade200,
                          border: Border.all(color: Colors.grey.shade600),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                            child: Text("All task",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold))),
                      ),
                    ),
                    // SizedBox(height: 10,),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreateTaskScreen()));
                        },
                        child: CustomWidgets()
                            .iconButton(context, Icons.add, 'Create task')),
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: StreamBuilder<QuerySnapshot>(
                                  stream: userProvider.showPending().asStream(),
                                  builder: (context, snapshot) {
                                    if(snapshot.hasData){
                                      final data = snapshot.data!;
                                      return  ManagerWidgets().reviewBox(
                                          Color(0xffFF6161),
                                          data.size.toString(),
                                          'Pending');
                                    }
                                    else{
                                      return Center(child: CircularProgressIndicator());
                                    }

                                  }),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 2,
                              child: StreamBuilder<QuerySnapshot>(
                                  stream: userProvider.showReview().asStream(),
                                  builder: (context, snapshot) {
                                    if(snapshot.hasData){
                                      final data = snapshot.data!;
                                      return  ManagerWidgets().reviewBox(
                                          Color(0xff6498FF),
                                          data.size.toString(),
                                          'review');
                                    }
                                    else{
                                      return Center(child: CircularProgressIndicator());
                                    }
                                  }),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: StreamBuilder<QuerySnapshot>(
                                  stream: userProvider.showInProgress().asStream(),
                                  builder: (context, snapshot) {
                                    if(snapshot.hasData){
                                      final data = snapshot.data!;
                                      return  ManagerWidgets().reviewBox(
                                          Color(0xffFFB164),
                                          data.size.toString(),
                                          'In progress');
                                    }
                                    else{
                                      return Center(child: CircularProgressIndicator());
                                    }
                                  }),

                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 2,
                              child: StreamBuilder<QuerySnapshot>(
                                  stream: userProvider.showComplete().asStream(),
                                  builder: (context, snapshot) {
                                    if(snapshot.hasData){
                                      final data = snapshot.data!;
                                      return  ManagerWidgets().reviewBox(
                                          Color(0xff64FF64),
                                          data.size.toString(),
                                          'Complete');
                                    }
                                    else{
                                      return Center(child: CircularProgressIndicator());
                                    }
                                  }),

                            )
                          ],
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Palette().maincolor,
                        // border: Border.all(color: Colors.grey.shade600),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                          child: Text("Task by user",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold))),
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
