import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dihillah/Custom/Palette.dart';
import 'package:dihillah/Model/task_model.dart';
import 'package:dihillah/Provider/users_managers_viewmodel.dart';
import 'package:dihillah/Provider/widgets_viewmodel.dart';
import 'package:dihillah/Views/manager/ManagerWidgets/manager_widgets.dart';
import 'package:dihillah/Widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateTaskScreen extends StatelessWidget {
  CreateTaskScreen({Key? key}) : super(key: key);

  TextEditingController _taskNameController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WidgetsViewModel()),
        ChangeNotifierProvider(create: (context) => UserManagerViewModel()),
      ],
      child: Consumer2<WidgetsViewModel, UserManagerViewModel>(
        builder: (context, widgetProvider, userProvider, child) => Scaffold(
          appBar: CustomWidgets().appbar("Create Task"),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 8),
            child: Container(
              height: size.height,
              width: size.width,
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Task name',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: TextField(
                          onChanged: (val) {
                            _taskNameController.text = val;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              filled: true,
                              fillColor: Colors.grey.shade100,

                              // contentPadding: EdgeInsets.all(16.0),
                              prefixIcon: Icon(
                                Icons.minimize,
                                color: Color(0xfffBABABA),
                              )),
                        ),
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Start',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      CustomWidgets().selectStartDate(context);
                                    },
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        color: Colors.grey.shade200,
                                        border: Border.all(
                                            color: Colors.grey.shade600),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: widgetProvider.selectedStartDate ==
                                              ""
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  'Date',
                                                  style: TextStyle(
                                                      color:
                                                          Colors.grey.shade700,
                                                      fontSize: 18),
                                                ),
                                                Text(
                                                  '(system)',
                                                  style: TextStyle(
                                                      color:
                                                          Colors.grey.shade700,
                                                      fontSize: 18),
                                                ),
                                              ],
                                            )
                                          : Center(
                                              child: Text(
                                                widgetProvider
                                                    .selectedStartDate!
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.grey.shade700,
                                                    fontSize: 18),
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'expecting date',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.0),
                                  child: GestureDetector(
                                      onTap: () {
                                        CustomWidgets().selectEndDate(context);
                                      },
                                      child: Container(
                                        // width: MediaQuery.of(context).size.width/2.3,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          color: Colors.grey.shade200,
                                          border: Border.all(
                                              color: Colors.grey.shade600),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: widgetProvider.selectedEndDate ==
                                                ""
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    'Calender',
                                                    style: TextStyle(
                                                        color: Colors
                                                            .grey.shade700,
                                                        fontSize: 18),
                                                  ),
                                                  Icon(
                                                    Icons.calendar_month,
                                                  )
                                                ],
                                              )
                                            : Center(
                                                child: Text(
                                                  widgetProvider
                                                      .selectedEndDate!
                                                      .toString(),
                                                  style: TextStyle(
                                                      color:
                                                          Colors.grey.shade700,
                                                      fontSize: 18),
                                                ),
                                              ),
                                      )),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Text(
                        'Particpate',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Row(
                        children: [
                          Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Palette().maincolor,
                                // border: Border.all(color: Colors.grey.shade600),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Icon(Icons.add,
                                  color: Colors.white, size: 30)),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0),
                              child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  width:
                                      MediaQuery.of(context).size.width / 2.7,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: Colors.grey.shade200,
                                    border:
                                        Border.all(color: Colors.grey.shade600),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: StreamBuilder<QuerySnapshot>(
                                    stream: userProvider.showUsers().asStream(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      return snapshot.hasData
                                          ? DropdownButtonHideUnderline(
                                              child: DropdownButton<String>(
                                                isExpanded: true,
                                                value: widgetProvider
                                                            .selectUser ==
                                                        ""
                                                    ? null
                                                    : widgetProvider.selectUser,
                                                items: snapshot.data!.docs
                                                    .map((doc) {
                                                  return DropdownMenuItem<
                                                          String>(
                                                      value: doc['userName'],
                                                      child: Text(
                                                        doc['userName'],
                                                      ));
                                                }).toList(),
                                                onChanged: (value) {
                                                  widgetProvider
                                                      .setSelectUser(value!);
                                                },
                                              ),
                                            )
                                          : Center(
                                              child:
                                                  CircularProgressIndicator());
                                    },
                                  )),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Task priority',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.grey.shade200,
                            border: Border.all(color: Colors.grey.shade600),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: widgetProvider.selectPriority,
                              items: ManagerWidgets().priorityItems,
                              onChanged: (value) {
                                widgetProvider.setPriority(value!);
                              },
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'Description',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.grey.shade200,
                              border: Border.all(color: Colors.grey.shade600),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: TextFormField(
                                onChanged: (val) {
                                  _descController.text = val;
                                },
                                keyboardType: TextInputType.multiline,
                                maxLines: 5,
                                maxLength: 5000,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            )),
                      ),
                      Text(
                        'Attach',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 6,
                              child: GestureDetector(
                                onTap: () {
                                  widgetProvider.filePicker();
                                },
                                child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * .72,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: Colors.grey.shade200,
                                      border: Border.all(
                                          color: Colors.grey.shade600),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: Icon(Icons.attachment),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: widgetProvider.file == null
                                              ? Text('Add an attachment',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold))
                                              : Container(
                                                  height: size.height * .03,
                                                  width: size.width * .5,
                                                  child: Text(
                                                      widgetProvider.file
                                                          .toString(),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () {
                                  widgetProvider.selectGalleryImage();
                                },
                                child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: Palette().maincolor,
                                      // border: Border.all(color: Colors.grey.shade600),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Icon(Icons.camera_alt,
                                        color: Colors.white, size: 30)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              await widgetProvider.uploadImage(context);
                              await widgetProvider.uploadFile(context);
                              await userProvider
                                  .getUser(widgetProvider.selectUser);
                              print(userProvider.userImage);

                              userProvider.assignTask(
                                  taskModel: TaskModel(
                                taskName: _taskNameController.text.trim(),
                                startDate:
                                    widgetProvider.selectedStartDate.toString(),
                                endDate:
                                    widgetProvider.selectedEndDate.toString(),
                                userName: widgetProvider.selectUser,
                                priority: widgetProvider.selectPriority,
                                description: _descController.text.trim(),
                                file: widgetProvider.fileUrlDownload,
                                image: widgetProvider.imageUrlDownload,
                                userImage: userProvider.userImage,
                              ));
                            }
                          },
                          child: CustomWidgets()
                              .iconButton(context, Icons.add, 'Create task')),
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
