import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dihillah/Custom/Palette.dart';
import 'package:dihillah/Provider/users_managers_viewmodel.dart';
import 'package:dihillah/Provider/widgets_viewmodel.dart';
import 'package:dihillah/Views/manager/ManagerWidgets/manager_widgets.dart';
import 'package:dihillah/Views/manager/all_users_messages_screen.dart';
import 'package:dihillah/Views/manager/create_task_screen.dart';
import 'package:dihillah/Views/manager/manager_home_screen.dart';
import 'package:dihillah/Views/manager/progress_task_screen.dart';
import 'package:dihillah/Widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:provider/provider.dart';

class ManagerMainScreen extends StatelessWidget {
  ManagerMainScreen({Key? key}) : super(key: key);

  PageController _pageController = PageController();
  late Animation<double> animation;
  late CurvedAnimation curve;

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
          floatingActionButton: Container(
            height: 85,
            width: 85,
            decoration: BoxDecoration(
              color: Palette().maincolor,
              borderRadius: BorderRadius.circular(150),
            ),
            child: FittedBox(
              child: FloatingActionButton(
                onPressed: () {
                  _pageController.jumpToPage(2);
                },
                child: Icon(
                  Icons.home,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            )
          ),

          floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: AnimatedBottomNavigationBar(
              backgroundColor: Palette().maincolor,
              height: 60,
              splashColor: Colors.white,
              icons: ManagerWidgets().iconList,
              iconSize: 35,
              activeColor: Colors.orange,
              inactiveColor: Colors.white,
              activeIndex: widgetProvider.bottomNavIndex,
              gapLocation: GapLocation.center,
              notchSmoothness: NotchSmoothness.softEdge,
              onTap: (index) {
                widgetProvider.setBottomNav(index);
                _pageController.jumpToPage(widgetProvider.bottomNavIndex);
                print(index);
              }
            //other params
          ),
          body: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              widgetProvider.setBottomNav(index);
            },
            children: <Widget>[
              AllUsersMessagesScreen(),
              AllUsersMessagesScreen(),
              ManagerHomeScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
