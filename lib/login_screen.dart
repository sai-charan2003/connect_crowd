import 'package:connect_crowd/chat_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class login_screen extends StatefulWidget {
  const login_screen({Key? key}) : super(key: key);
  static const String pageid='login_screen';


  @override
  State<login_screen> createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {
  bool _saving=false;
  final _auth=FirebaseAuth.instance;
  late String email;
  late String password;
  var errormessage;

  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
        Scaffold(
          backgroundColor: Colors.white,

          body: ModalProgressHUD(
            inAsyncCall: _saving,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 160.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Hero(
                      tag: 'logo',
                      child: Container(
                          child:Image.asset('images/Connect Crowd.png'),
                        height: 200.0,
                      ),
                    ),
                    SizedBox(height: 50.0),

                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                          onChanged: (value){
                          email=value;

                          },

                          style: const TextStyle(color: Colors.black),decoration: const InputDecoration(prefixIcon: Icon(Icons.account_circle_outlined,color: Colors.black),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue,width: 3.0),borderRadius: BorderRadius.all(Radius.circular(32.0))
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                            borderRadius: BorderRadius.all(Radius.circular(32.0)),
                          )

                      ),
                          cursorColor: Colors.red



                      ),

                    ),
      SizedBox(height: 10.0,),
       Padding(
        padding: EdgeInsets.all(8.0),
        child: TextField(
            obscureText: true,
            onChanged: (value){
              password=value;
            },
            style: const TextStyle(color: Colors.black),decoration: const InputDecoration(prefixIcon: Icon(Icons.password_outlined,color: Colors.black),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue,width: 3.0),borderRadius: BorderRadius.all(Radius.circular(32.0))
                ),
            focusedBorder: OutlineInputBorder(
                borderSide:
                BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(32.0)),
            )
        ),
            cursorColor: Colors.red,),
      ),
                    SizedBox(height:40.0),
                    Material(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.blue,
                        child: MaterialButton(onPressed: () async {
                          setState(() {
                            _saving = true;
                          });
                          try {
                            final user = await _auth.signInWithEmailAndPassword(
                                email: email, password: password);
                            _saving=true;
                            if(user!=null){
                              Navigator.pushNamed(context, chat_screen.id);
                            }
                          }
                          catch(e){
                            print(e);




                          }

                        },child: Text('Login'),enableFeedback: true)),


                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}
