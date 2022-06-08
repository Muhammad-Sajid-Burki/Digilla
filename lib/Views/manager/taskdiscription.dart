import 'package:dihillah/Custom/Palette.dart';
import 'package:dihillah/Widgets/widgets.dart';
import 'package:flutter/material.dart';
// import 'package:percent_indicator/circular_percent_indicator.dart';

class TaskDiscription extends StatefulWidget {
  

  @override
  State<TaskDiscription> createState() => _TaskDiscriptionState();
}

class _TaskDiscriptionState extends State<TaskDiscription> {
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = new TextEditingController();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar:  PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBar(
          automaticallyImplyLeading: false,
        backgroundColor: Palette().maincolor,
        leading: Padding(
          padding: const EdgeInsets.only(top: 20,left: 20),
          child: CircleAvatar(
            radius: 50,
            backgroundImage:AssetImage('assets/profileImage.png',),),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            
            children: [
              Text('User',style: TextStyle(color: Colors.white,fontSize: 13),),
              Text('Amar baig',style: TextStyle(color: Colors.white),),
            ],
          ),
        ),
        actions: [
            Padding(
              padding: const EdgeInsets.only(top: 32,right: 20,bottom: 10),
              child: Icon(Icons.notification_add),
            ),
            
            Padding(
              padding: const EdgeInsets.only(top: 32,right: 20,bottom: 10),
              child: Icon(Icons.person),
            ),
            
          ],  
        
        ),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Task 2',style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.bold),),
                      Text('Task Title',style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),)
                    ],
                  ),
                  SizedBox(width:50 ,),
                  Padding(
                    padding: const EdgeInsets.only(left: 70),
                    child: Expanded(
                      flex: 1,
                      child: Text('update status')),
                  ),
                   Expanded(
                     flex: 2,
                     child: Container(
                                 padding: EdgeInsets.all(16),
                             //     child: CircularPercentIndicator( //circular progress indicator
                             //      radius: 45.0, //radius for circle
                             //      lineWidth: 5.0, //width of circle line
                             //     //  animation: true, //animate when it shows progress indicator first
                             //      percent: 60/100, //vercentage value: 0.6 for 60% (60/100 = 0.6)
                             //      center: Text("75%",style: TextStyle(
                             //        fontWeight: FontWeight.bold, fontSize: 12.0),
                             //      ), //center text, you can set Icon as well
                             //     //footer text
                             //      backgroundColor: Colors.grey, //backround of progress bar
                             //      circularStrokeCap: CircularStrokeCap.round, //corner shape of progress bar at start/end
                             //      progressColor: Colors.blue, //progress bar color
                             // ),
                               ),
                   ),
                ],
                
              ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Start date',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.blue,
                              fontWeight: FontWeight.w700),
                        ),
                         SizedBox(
                          height: 4,
                        ),
                        Text(
                          '21-May-2022',
                          style:
                              TextStyle(fontSize: 12,color:Palette().fontcolor,fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    // SizedBox(
                    //   width: 20,
                    // ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Expected date',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.blue,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          '25-June-2022',
                          style:
                              TextStyle(fontSize: 12, color: Palette().fontcolor,fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
              ],
            ),
            SizedBox(height: 20,),
            Container(
              height: size.height*.3,
              // color: Colors.amber,
              child: Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.\n It has survived not only five centuries Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry,',
              style: TextStyle( color: Palette().fontcolor,fontWeight: FontWeight.bold),
              ),
              
            ),
            Text('comments',style:TextStyle(fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w700) ,),
            SizedBox(height: 12,),
            Divider(
              height: 1,
              color: Colors.grey.shade400,
              thickness: 2,
              indent: 20,
              endIndent: 20,
            ),
            SizedBox(height: 8,),
            Container(
              height:size.height*.2,
              // color: Colors.black,
              // child: Text('comments'),
            ),
            SizedBox(height: 8,),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                      decoration: BoxDecoration(
                        // shape: BoxShape.rectangle,
                        color: Colors.grey.shade200,
                        border: Border.all(color: Colors.grey.shade600),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        textAlign: TextAlign.start,
                        controller: controller,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'type here...',
                          hintStyle: TextStyle(fontSize: 16,color: Palette().fontcolor),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          filled: true,
                          contentPadding: EdgeInsets.all(16),
                        ),
                      ),
                    ),
                ),
                  Expanded(
                    
                    child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Container(
                          // width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Palette().maincolor,
                          // border: Border.all(color: Colors.grey.shade600),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                          child:Icon(Icons.attachment,color: Colors.white,size: 30)
                        ),
                        ),
                  ),
              ],
            ),
            
            ],
          ),
        ),
      ),
      
      
      );
     
  }
}
