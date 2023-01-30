import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'welcome_screen.dart';
import 'chat_screen.dart';
import 'registration_screen.dart';
import 'login_screen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      initialRoute: welcome_screen.pageid,
      routes: {
        login_screen.pageid: (context)=>login_screen(),
        welcome_screen.pageid: (context)=>welcome_screen(),
        registration_screen.pageid: (context)=>registration_screen(),
        chat_screen.id: (context)=>chat_screen()
      },
    );
  }
}



