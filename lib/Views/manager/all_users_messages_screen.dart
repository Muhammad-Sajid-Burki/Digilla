import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dihillah/Provider/manager_signin_viewmodel.dart';
import 'package:dihillah/Provider/users_managers_viewmodel.dart';
import 'package:dihillah/Views/manager/ManagerWidgets/chatroom_widget.dart';
import 'package:dihillah/Views/manager/ManagerWidgets/manager_widgets.dart';
import 'package:dihillah/Widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllUsersMessagesScreen extends StatelessWidget {

  TextEditingController messegeSearchCont = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MultiProvider(providers: [
        ChangeNotifierProvider(create: (context) => UserManagerViewModel()),
        ChangeNotifierProvider(create: (context) => ManagerSignInViewModel()),
    ],

      child: Consumer2<UserManagerViewModel, ManagerSignInViewModel>(
        builder: (context, provider,userProvider, child) => Scaffold(
          appBar: CustomWidgets().appbar('Messages'),
          body: Container(
            height: size.height,
            width: size.width,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 50),
                child: Column(
                  children: [
                    CustomWidgets().searchBar(messegeSearchCont),
                    SizedBox(height: 20,),
                    Container(
                      height: size.height * .64,
                      width: size.width,
                      child: StreamBuilder<QuerySnapshot>(
                          stream: provider.showUsers().asStream(),
                          builder: (context, snapshot){
                            if (snapshot.hasData){
                              return ListView.builder(
                                  itemCount: snapshot.data?.docs.length,
                                  itemBuilder: (context, index){
                                    DocumentSnapshot data =
                                    snapshot.data!.docs[index];
                                    return GestureDetector(
                                        onTap: (){
                                          ChatRoomWidgets().creatChatRoomAndStartConversation(context,username:data['userName'],userImage:data['imageUrl'],providerUserName: userProvider.userModel.userName.toString(), providerImageUrl: userProvider.userModel.imageUrl.toString());
                                        },
                                        child: ChatRoomWidgets().messageList(data['userName'],data['email'],data['imageUrl']));
                                  });
                            }
                            else{
                              return Center(child: CircularProgressIndicator(),);
                            }
                          }),
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
