import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dihillah/Provider/users_managers_viewmodel.dart';
import 'package:dihillah/Views/manager/ManagerWidgets/manager_widgets.dart';
import 'package:dihillah/Views/manager/progress_task_detail_screen.dart';
import 'package:dihillah/Widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class Progresstask extends StatefulWidget {
  @override
  State<Progresstask> createState() => _ProgresstaskState();
}

class _ProgresstaskState extends State<Progresstask> {
  TextEditingController searchbarCont = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(create: (context) => UserManagerViewModel(),
      child: Consumer<UserManagerViewModel>(
        builder: (context, provider, child) => Scaffold(
          appBar: CustomWidgets().appbar('Progress Task'),
          body: Container(
            height: size.height,
            width: size.width,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 10),
                child: Column(children: [
                  CustomWidgets().searchBar(searchbarCont),
                  Container(
                    height: size.height * .55,
                    width: size.width,
                    child: StreamBuilder<QuerySnapshot>(
                        stream: provider.showTasks().asStream(),
                        builder: (context, snapshot) {
                          return snapshot.hasData ? ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                DocumentSnapshot data =
                                    snapshot.data!.docs[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProgressTaskDetailsScreen(data: data)));
                                  },
                                    child: ManagerWidgets().taskContainer(context, data['userImage'], data['taskName'], data["userName"], data['startDate'], data['endDate'], data['progress'], data['priority']));
                              }) : Center(child: CircularProgressIndicator());
                        }),
                  ),

                  SizedBox(
                    height: size.height * .12,
                  ),
                  CustomWidgets().iconButton(context, Icons.person, 'Add user'),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


