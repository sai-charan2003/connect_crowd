import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:fluttertoast/fluttertoast.dart';

class registration_screen extends StatefulWidget {
  const registration_screen({Key? key}) : super(key: key);
  static const String pageid='registration_screen';

  @override
  State<registration_screen> createState() => _registration_screenState();
}

class _registration_screenState extends State<registration_screen> {
  bool _saving=false;
  late var errormessage;


  final auth=FirebaseAuth.instance;
  late String email;
  late String password;
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      body:
        ModalProgressHUD(
          inAsyncCall: _saving,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 100.0),
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      child: Image.asset('images/Connect Crowd.png'),
                      height: 200.0,



                    ),
                  ),

                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value){
                      email=value;

                    },
                      style: TextStyle(color: Colors.black),decoration: InputDecoration(labelText:"Email Address",labelStyle:TextStyle(color: Colors.blue),floatingLabelBehavior: FloatingLabelBehavior.never,prefixIcon: Icon(Icons.email_outlined,color: Colors.black),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),borderSide: BorderSide(color:Colors.blue,width:3.0)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),borderSide: BorderSide(color:Colors.blue,width: 3.0 ))

                  ) ),
                ),
                Padding(padding: EdgeInsets.all(8.0),
                child: TextField(

                  onChanged: (value){
                    password=value;
                  },
                  obscureText: true,
                    style: TextStyle(color: Colors.black),decoration: InputDecoration(labelText:"Password",labelStyle:TextStyle(color: Colors.blue),floatingLabelBehavior: FloatingLabelBehavior.never,prefixIcon: Icon(Icons.password_outlined,color: Colors.black),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),borderSide: BorderSide(color:Colors.blue,width:3.0)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),borderSide: BorderSide(color:Colors.blue,width: 3.0 ))

                ) ),),

                SizedBox(height: 10.0),
                Material(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.blueAccent,
                  child: MaterialButton(onPressed: () async {
                    setState(() {
                      _saving=true;
                    });
                    try{
                      final newuser=await auth.createUserWithEmailAndPassword(email: email, password: password);
                      if(newuser!=null){
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>chat_screen()), (route) => false);
                      }
                    }
                    catch(e){
                      errormessage=e.toString();
                      Fluttertoast.showToast(msg: errormessage,gravity: ToastGravity.CENTER);
                    }


                  },



                    child: Text('Register'),


                  ),
                )

              ],
            ),
          ),
        )
    ));
  }
}
