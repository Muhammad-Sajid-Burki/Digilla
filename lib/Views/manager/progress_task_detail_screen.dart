import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dihillah/Custom/Palette.dart';
import 'package:dihillah/Views/Admin/AdminWidgets/admin_widgets.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProgressTaskDetailsScreen extends StatelessWidget {
  ProgressTaskDetailsScreen({Key? key, required this.data}) : super(key: key);

  DocumentSnapshot data;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _taskNameController = TextEditingController();
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();
  TextEditingController _priorityController = TextEditingController();
  TextEditingController _fileController = TextEditingController();
  TextEditingController _imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    _nameController.text = data['userName'];
    _taskNameController.text = data['taskName'];
    _startDateController.text = data['startDate'];
    _endDateController.text = data['endDate'];
    _priorityController.text = data['priority'];
    _fileController.text = data['file'];
    _imageController.text = data['image'];

    final Uri _fileurl = Uri.parse(data['file']);
    final Uri _imageurl = Uri.parse(data['image']);

    void _fileLaunchUrl() async {
      if (!await launchUrl(_fileurl)) throw 'Could not launch $_fileurl';
    }

    void _imageLaunchUrl() async {
      if (!await launchUrl(_imageurl)) throw 'Could not launch $_imageurl';
    }

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

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: TextFormField(
                                readOnly: true,
                                controller: _taskNameController,
                                decoration: AdminWidgets().textFieldInputDecoration('Task Name', Icons.task),

                              ),
                            ),
                            TextFormField(
                              readOnly: true,
                              controller: _nameController,
                              decoration: AdminWidgets().textFieldInputDecoration('User Name', Icons.person),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: TextFormField(
                                readOnly: true,
                                controller: _startDateController,
                                decoration: AdminWidgets().textFieldInputDecoration('Start Date', Icons.date_range_outlined),

                              ),
                            ),
                            TextFormField(
                              readOnly: true,
                              controller: _endDateController,
                              decoration: AdminWidgets().textFieldInputDecoration('End Date', Icons.date_range_rounded),

                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: TextFormField(
                                readOnly: true,
                                controller: _priorityController,
                                decoration: AdminWidgets().textFieldInputDecoration('Priority', Icons.priority_high),

                              ),
                            ),
                            TextFormField(
                              onTap: _fileLaunchUrl,
                              readOnly: true,
                              controller: _fileController,
                              decoration: AdminWidgets().textFieldInputDecoration('File', Icons.file_open_outlined),

                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Container(
                                child: TextFormField(
                                  onTap: _imageLaunchUrl,
                                  readOnly: true,
                                  controller: _imageController,
                                  decoration: AdminWidgets().textFieldInputDecoration('Image', Icons.image),

                                ),
                              ),
                            ),


                            Padding(
                              padding: const EdgeInsets.only(top: 40),
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 2,
                                      child: GestureDetector(
                                          onTap: () {
                                          },
                                          child: AdminWidgets().adminProfileButton('Start', Palette().maincolor))
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: GestureDetector(
                                          onTap: () {
                                          },
                                          child: AdminWidgets().adminProfileButton('InProgress', Colors.grey))
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: GestureDetector(
                                          onTap: () {
                                          },
                                          child: AdminWidgets().adminProfileButton('Complete', Colors.grey))
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

}