import 'package:connect_crowd/chat_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class login_screen extends StatefulWidget {
  const login_screen({Key? key}) : super(key: key);
  static const String pageid='login_screen';



  @override

  State<login_screen> createState() => _login_screenState();
}


class _login_screenState extends State<login_screen> {
  //late SharedPreferences logindata;
  //late bool newuser;
  bool _saving=false;
  final _auth=FirebaseAuth.instance;
  late String email;
  late String password;
  var errormessage;
  TextEditingController username=TextEditingController();
  TextEditingController passtext=TextEditingController();
  // void initState() {
  //   // TODO: implement initState
  //   check_if_login();
  //   super.initState();
  // }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    username.dispose();
    passtext.dispose();
  }





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
                        controller: username,
                        keyboardType: TextInputType.emailAddress,
                          onChanged: (value){
                          email=value;

                          },

                          style: const TextStyle(color: Colors.black),decoration: const InputDecoration(labelText:"Email Address",labelStyle:TextStyle(color: Colors.blue),floatingLabelBehavior: FloatingLabelBehavior.never,prefixIcon: Icon(Icons.email_outlined,color: Colors.black),

                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue,width: 3.0),borderRadius: BorderRadius.all(Radius.circular(10.0))
                          ),


                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.blue, width: 2.0),
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          )

                      ),
                          cursorColor: Colors.red



                      ),

                    ),
      SizedBox(height: 10.0,),
       Padding(
        padding: EdgeInsets.all(8.0),
        child: TextField(
          controller: passtext,
            obscureText: true,
            onChanged: (value){
              password=value;
            },
            style: const TextStyle(color: Colors.black),decoration: const InputDecoration(labelText:"Password",labelStyle:TextStyle(color: Colors.blue),floatingLabelBehavior: FloatingLabelBehavior.never,prefixIcon: Icon(Icons.password_outlined,color: Colors.black),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue,width: 3.0),borderRadius: BorderRadius.all(Radius.circular(10.0))
                ),
            focusedBorder: OutlineInputBorder(
                borderSide:
                BorderSide(color: Colors.blue, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
            )
        ),
            cursorColor: Colors.red,),
      ),
                    SizedBox(height:40.0),
                    Material(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.blue,
                        child: MaterialButton(onPressed: () async {

                          try {
                            final user = await _auth.signInWithEmailAndPassword(
                                email: username.text, password: passtext.text);
                            _saving=true;
                            if(user!=null) {
                              final pref= await SharedPreferences.getInstance();
                              pref.setBool('isLoggedIn', true);



                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>chat_screen()), (route) => false);
                              //logindata.setBool('login', false);
                              //logindata.setString('email', email);


                            }
                          }
                          catch(e){
                            print(e);
                            errormessage=e.toString();
                            Fluttertoast.showToast(msg: errormessage,gravity: ToastGravity.CENTER);




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
  // void check_if_login() async {
  //   logindata = await SharedPreferences.getInstance();
  //
  //   newuser = (logindata.getBool('login') ?? true);
  //   if (newuser == false) {
  //     Navigator.pushNamed(context, chat_screen.id);
  //   }
  // }



}
