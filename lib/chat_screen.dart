// import 'dart:html';

import 'package:connect_crowd/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class chat_screen extends StatefulWidget {
  const chat_screen({Key? key}) : super(key: key);
  static const String id='chat_screen';

  @override
  State<chat_screen> createState() => _chat_screenState();
}

class _chat_screenState extends State<chat_screen> {
  final _auth=FirebaseAuth.instance;
  final _firestore=FirebaseFirestore.instance;
  late User loggedinuser;
  late String messagetext;
  final messageTextController = TextEditingController();
  @override
  void initState() {
    getdata();
    super.initState();
  }


  void getdata()async{
    final details= await _auth.currentUser;
    try {
      if (details != null) {
        loggedinuser = details;
      }
    }
    catch(e){
      print(e);
    }



  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(centerTitle:true,title: Text('Connect Crowd',style: TextStyle(fontWeight: FontWeight.w900),),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.0))),
        actions: [IconButton(onPressed: (){
          Navigator.pushNamed(context, welcome_screen.pageid);
        }, icon: Icon(Icons.logout))],
      ),
    body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,

        children: <Widget>[
          StreamBuilder<QuerySnapshot>(stream: _firestore.collection('messages').orderBy('time').snapshots(),
            builder: (context,snapshot) {
              if (snapshot.hasData) {
                final messages = snapshot.data!.docs.reversed;
                List<Messagebubble> messageWidgets=[];
                for (var message in messages) {
                  var data=message.data() as Map;
                  var messagetext=data['message'];
                  var messageuser=data['user'];
                  var user=loggedinuser.email;

                    final messagewidget = Messagebubble(messageuser, messagetext,user==messageuser);
                    messageWidgets.add(messagewidget);


                }
                return Expanded(
                  child: ListView(
                    reverse: true,


                    children: messageWidgets,
                  ),
                );
              }
              return SizedBox();


            }
        ),



        Container(
          child: Row(
            children: [
              Expanded(

                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: TextField(
                    controller: messageTextController,
                    onChanged: (value){

                      messagetext=value;
                    },
                    style: TextStyle(color:Colors.black),decoration: InputDecoration(prefixIcon: Icon(Icons.chat,color: Colors.black,),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)
                    ,borderSide: BorderSide(width: 3.0,color: Colors.black),

                    ),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0),borderSide: BorderSide(width: 3.0,color:Colors.black))
                  ),

                  ),
                ),



              ),
              TextButton(onPressed: (){
                _firestore.collection('messages').add({'message':messagetext,'user':loggedinuser.email,'time':FieldValue.serverTimestamp()});
                messageTextController.clear();

              }, child: Text('Send'))
            ],

          ),
        ),

      ],),
    ),
    ));
  }
}
class Messagebubble extends StatelessWidget {
  Messagebubble(this.user,this.message,this.isme);
  final String user;
  final String message;
  final bool isme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isme ? CrossAxisAlignment.end: CrossAxisAlignment.start,
        children: [
          Text(user,style: TextStyle(color:Colors.black),),
          Material(
            borderRadius: isme ? BorderRadius.only(topLeft: Radius.circular(30.0),bottomLeft: Radius.circular(30.0),bottomRight: Radius.circular(30.0))
            :BorderRadius.only(bottomLeft: Radius.circular(30.0),bottomRight: Radius.circular(30.0),topRight: Radius.circular(30.0),
            ),
            elevation: 10.0,

            color: isme ?Colors.blue: Colors.green,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(message,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w900),),
              )),
        ],
      ),
    );
  }
}


