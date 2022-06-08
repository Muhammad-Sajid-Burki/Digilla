import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dihillah/Custom/Palette.dart';
import 'package:dihillah/Provider/manager_signin_viewmodel.dart';
import 'package:dihillah/Provider/widgets_viewmodel.dart';
import 'package:dihillah/Services/database.dart';
import 'package:dihillah/Views/manager/ManagerWidgets/chatroom_widget.dart';
import 'package:dihillah/Widgets/widgets.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ConversationScreen extends StatelessWidget {
  final String chatRoomId;
  final String userName;
  final String imageUrl;

  ConversationScreen(
      {Key? key,
      required this.chatRoomId,
      required this.userName,
      required this.imageUrl})
      : super(key: key);

  TextEditingController _messagecontroller = new TextEditingController();

  DatabaseMethod databaseMethod = DatabaseMethod();

  @override
  Widget build(BuildContext context) {
    // here we set the timer to call the event
    // Timer(
    //     Duration(milliseconds: 200),
    //     () => ChatRoomWidgets().scrollController
    //         .jumpTo(ChatRoomWidgets().scrollController.position.maxScrollExtent));

    return MultiProvider(providers: [
        ChangeNotifierProvider(create: (context) => ManagerSignInViewModel()),
        ChangeNotifierProvider(create: (context) => WidgetsViewModel()),
    ],
      child: Consumer2<ManagerSignInViewModel, WidgetsViewModel>(
        builder: (context, provider, widgetProvider, child) {
          databaseMethod.getConversationMessage(chatRoomId).then((value){
            widgetProvider.setChatStream(value);
          });
          return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Colors.pinkAccent,
                      borderRadius: BorderRadius.circular(40),
                      image: DecorationImage(
                          image: NetworkImage(imageUrl), fit: BoxFit.cover)),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(userName,
                    style: TextStyle(
                        color: Palette().maincolor,
                        fontSize: 20,
                        fontWeight: FontWeight.w700))
              ],
            ),
          ),
          body: Container(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 80),
                  child: ChatRoomWidgets().chatMessageList(
                    context,
                    provider.userModel.userName.toString(),
                    chatRoomId,
                    widgetProvider.chatMessageStream
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    color: Color(0x54ffffff),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    child: Row(
                      children: [
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextField(
                            controller: _messagecontroller,
                            style: TextStyle(color: Palette().maincolor),
                            decoration: InputDecoration(
                              hintText: "Message...",
                              hintStyle: TextStyle(color: Palette().fontcolor),
                              border: InputBorder.none,
                            ),
                          ),
                        )),
                        GestureDetector(
                          onTap: () {
                            print('doneeee');
                            // ChatRoomWidgets().scrollController.animateTo(
                            //     ChatRoomWidgets().scrollController.position.maxScrollExtent,
                            //     duration: Duration(milliseconds: 300),
                            //     curve: Curves.easeOut);
                            ChatRoomWidgets().sendMessage(provider.userModel.userName.toString(), chatRoomId, _messagecontroller);
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Palette().maincolor,
                                      Palette().fontcolor,
                                      Palette().maincolor,
                                    ]),
                                borderRadius: BorderRadius.circular(40)),
                            child: Center(child: Icon(Icons.send)),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
        },
      ),
    );
  }
}
