import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ManagerWidgets {

  Widget taskContainer(BuildContext context,String userImage, String taskName, String userName, String startDate, String endDate, int taskComplete, String priority) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Container(
        height: size.height * .12,
        width: size.width,
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade600, width: 1)),
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
                            image: NetworkImage(userImage)
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$taskName assign to',
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey.shade600),
                        ),
                        Text(
                          '$userName',
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Start date',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  '$startDate',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Expected date',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  '$endDate',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Center(
                child: Column(
                  children: [
                    CircularPercentIndicator(
                      //circular progress indicator
                      radius: 25.0,
                      //radius for circle
                      lineWidth: 5.0,
                      //width of circle line
                      //  animation: true, //animate when it shows progress indicator first
                      percent: taskComplete / 100,
                      //vercentage value: 0.6 for 60% (60/100 = 0.6)
                      center: Text(
                        "$taskComplete%",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
                      ),
                      //center text, you can set Icon as well
                      //footer text
                      backgroundColor: Colors.grey,
                      //backround of progress bar
                      circularStrokeCap: CircularStrokeCap.round,
                      //corner shape of progress bar at start/end
                      progressColor: Colors.blue, //progress bar color
                    ),
                    SizedBox(height: 5,),
                    Text(
                      '$priority',
                      style: TextStyle(
                          fontSize: 10, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container reviewBox(Color color, String string1, String string2) {
    return Container(
      height: 170,
      // color: Colors.amber,
      decoration:BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10,top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(string1,style: TextStyle(color: Colors.white,fontSize: 70,fontWeight: FontWeight.bold),),
            Text(string2,style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> get priorityItems{
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Low"),value: "Low"),
      DropdownMenuItem(child: Text("Medium"),value: "Medium"),
      DropdownMenuItem(child: Text("High"),value: "High"),
    ];
    return menuItems;
  }

  final iconList = <IconData>[
    Icons.list,
    Icons.email,
  ];


}