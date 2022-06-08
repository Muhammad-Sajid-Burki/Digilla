import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:dihillah/Custom/Palette.dart';
import 'package:dihillah/Widgets/widgets.dart';
import 'package:flutter/material.dart';

class PendingTask extends StatefulWidget {
  const PendingTask({ Key? key }) : super(key: key);

  @override
  State<PendingTask> createState() => _PendingTaskState();
}

class _PendingTaskState extends State<PendingTask> {
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
      appBar: CustomWidgets().appbar('Pending task'),
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
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                child: Column(
                  children: [
                    pendingtask(),
                    SizedBox(height: 12,),
                    pendingtask(),
                    SizedBox(height: 12,),
                    pendingtask(),
                    SizedBox(height: 12,),
                    pendingtask(),
                    SizedBox(height: 12,),
                    
                  ],
                ),
              ),
            ),
            
    );
  }

  Card pendingtask() {
    return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(color: Colors.grey.shade500,width: 2),
                    ),
                    color: Colors.grey.shade200,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text('Fix System',style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),
                        subtitle: Row(
                          children: [
                            Text('Start date',style: TextStyle(color: Colors.blue,fontSize: 15,fontWeight: FontWeight.bold)),
                            SizedBox(width: 12,),
                            Text('21-Oct-2021',style: TextStyle(color: Palette().fontcolor,fontSize: 15,fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  );
  }
}