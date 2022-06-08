import 'package:dihillah/Custom/Palette.dart';
import 'package:dihillah/Widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class UserHome extends StatefulWidget {
  const UserHome({ Key? key }) : super(key: key);

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> with SingleTickerProviderStateMixin{
  // final autoSizeGroup = AutoSizeGroup();
  var _bottomNavIndex = 0; //default index of a first screen

  late AnimationController _animationController;
  late Animation<double> animation;
  late CurvedAnimation curve;

  final iconList = <IconData>[
    Icons.menu,
    Icons.email,
  ];


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomWidgets().appbar(''),
       floatingActionButton: Container(
         height: 85,
         width: 85,
         decoration: BoxDecoration(
           color: Palette().maincolor,
           borderRadius: BorderRadius.circular(150), 
           ),
         child: Icon(Icons.home, color: Colors.white, size: 40,),
    //params
   ),
   floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
   bottomNavigationBar: AnimatedBottomNavigationBar(
     backgroundColor: Palette().maincolor,
     height: 60,
    splashColor: Colors.white,
    icons: iconList,
    iconSize: 35,
    activeColor: Colors.white,
    inactiveColor: Colors.white,
    activeIndex: _bottomNavIndex,
    gapLocation: GapLocation.center,
    notchSmoothness: NotchSmoothness.softEdge,
    onTap: (index) => setState(() => _bottomNavIndex = index),
    //other params
   ),
     
      body: Container(
        width: size.width,
        height: size.height,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Hi",style: TextStyle(color: Palette().fontcolor,fontSize: 25,fontWeight: FontWeight.bold),),
                Text("User name",style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold),),
                Text('You have 6 task\n to review',style: TextStyle(color: Palette().fontcolor,fontSize: 15,fontWeight: FontWeight.bold)),
                SizedBox(height: 20,),
                Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: Colors.grey.shade200,
                                      border: Border.all(color: Colors.grey.shade600),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Row(
                                     
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 15),
                                          child: Icon(Icons.attachment),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 15),
                                          child: Text('Add an attachment',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold)),
                                        ),
                                        
                                        
                                      ],
                                    )
                                  ),
                                  SizedBox(height: 20,)
,                  Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: reviewBox(Color(0xffFF6161),'10','Pending'),
                   

                      
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      flex: 2,
                       child: Container(
                    height: 170,
                    // color: Colors.amber,
                    decoration:BoxDecoration(
                      color:Color(0xff6498FF),
                     borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10,top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('6',style: TextStyle(color: Colors.white,fontSize: 70,fontWeight: FontWeight.bold),),
                          Text( 'waiting for\nApproval',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                  )
                      
                      
                      
                    )
                  ],
                ),
                SizedBox(height: 10,),
                 Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: reviewBox(Color(0xffFFB164),'6','In Progress'),
                      
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      flex: 2,
                      child: reviewBox(Color(0xff64FF64), '8', 'Complete'),
                    )
                  ],
                ),
                SizedBox(height: 10,
                ),
                
                
              ],
            ),
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
}