import 'package:dihillah/Widgets/widgets.dart';
import 'package:flutter/material.dart';
// import 'package:percent_indicator/circular_percent_indicator.dart';

class ManagerTaskDet extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomWidgets().appbar('Task by user'),
      body: Container(
        width: size.width,
        height: size.height,
        child: 
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 ListTile(
        contentPadding: EdgeInsets.only(left: 2),
      leading: CircleAvatar(
        backgroundColor: Colors.black,
        // radius: 25,
        backgroundImage: AssetImage('assets/profileImage.png',),
        child: GestureDetector(onTap: () {}),
        ),
        title: Text('User',style: TextStyle(
              fontSize: 12,
              color: Colors.black,
              fontWeight: FontWeight.w600),),
        subtitle: Text('Amer baig',style: TextStyle(
              fontSize: 25,
              color: Colors.black,
              fontWeight: FontWeight.bold),),
              ),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Task List',style: TextStyle(
              fontSize: 25,
              color: Colors.black,
              fontWeight: FontWeight.bold),),
              SizedBox(
                height: 16,
              ),
              TaskDetail(),
              SizedBox(height: 12,),
              TaskDetail(),
              SizedBox(height: 12,),
              TaskDetail(),
              SizedBox(height: 12,),
              TaskDetail(),
              SizedBox(height: 12,),



              ],
            ),
          ),
        ),
      ),
      
    );
  }
}

class TaskDetail extends StatelessWidget {
  const TaskDetail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(color: Colors.grey.shade500,width: 2)
      ),
      color: Colors.grey.shade200,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Task 1',style: TextStyle(
    fontSize: 12,
    color: Colors.grey.shade700,
    fontWeight: FontWeight.bold),),
              Text('Task title',style: TextStyle(
    fontSize: 22,
    color: Colors.black,
    fontWeight: FontWeight.bold),)
            ],
          ),
          subtitle: Text('26-11-2022',style: TextStyle(
    fontSize: 14,
    color: Colors.grey.shade700,
    fontWeight: FontWeight.bold),
    
    ),
          // trailing: CircularPercentIndicator( //circular progress indicator
          //  radius: 45.0, //radius for circle
          //  lineWidth: 5.0, //width of circle line
          // //  animation: true, //animate when it shows progress indicator first
          //  percent: 60/100, //vercentage value: 0.6 for 60% (60/100 = 0.6)
          //  center: Text("75%",style: TextStyle(
          //    fontWeight: FontWeight.bold, fontSize: 12.0),
          //  ), //center text, you can set Icon as well
          // //footer text
          //  backgroundColor: Colors.grey, //backround of progress bar
          //  circularStrokeCap: CircularStrokeCap.round, //corner shape of progress bar at start/end
          //  progressColor: Colors.blue, //progress bar color
          // ),
        ),
      ),
    );
  }
}