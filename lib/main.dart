import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'welcome_screen.dart';
import 'chat_screen.dart';
import 'registration_screen.dart';
import 'login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp( MyApp(isLoggedIn: isLoggedIn));
}
class MyApp extends StatelessWidget {
  bool isLoggedIn;
  final _auth=FirebaseAuth.instance;

  MyApp({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: _auth.authStateChanges(),
          builder: (BuildContext context,AsyncSnapshot snapshot) {
            if(snapshot.data != null){
              return chat_screen();
            }
            else{
              return welcome_screen();
            }

          },


        ),
    );
  }
}





