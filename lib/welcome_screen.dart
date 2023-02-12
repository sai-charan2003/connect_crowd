// import 'dart:html';

import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'main.dart';
import 'package:animated_text_kit/animated_text_kit.dart';


class welcome_screen extends StatefulWidget {
  const welcome_screen({Key? key}) : super(key: key);
  static const String pageid='welcome_screen';

  @override
  State<welcome_screen> createState() => _welcome_screenState();
}

class _welcome_screenState extends State<welcome_screen> with SingleTickerProviderStateMixin {
  @override
  late AnimationController controller;
  late Animation animation;
  @override
  List<MaterialColor> colorizeColors = [
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];

   TextStyle colorizeTextStyle = TextStyle(
    fontSize: 30.0,
    fontWeight: FontWeight.bold
    //fontFamily: 'Horizon',
  );
  void initState() {
    // TODO: implement initState
    controller=AnimationController(vsync: this,duration: Duration(seconds: 1));
    //animation= CurvedAnimation(parent: controller, curve: Curves.decelerate);
    animation=ColorTween(begin: Colors.blue[300],end: Colors.white).animate(controller);



    controller.forward();

    controller.addListener(() { setState(() {
      animation.value;

    });});
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {


    return SafeArea(child: Scaffold(
      backgroundColor: animation.value,

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/Connect Crowd.png'),
                    height: 80,
                  ),
                ),
                SizedBox(width: 20.0,),
                AnimatedTextKit( animatedTexts: [
                  ColorizeAnimatedText(
                  'Connect Crowd',
                  textStyle: colorizeTextStyle,
                  colors: colorizeColors,
                  )
  ]

                ),
              ],
            ),
            SizedBox(height: 70.0,),
            Material(
              borderRadius: BorderRadius.circular(10.0),
                color: Colors.blue,
                child: MaterialButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>login_screen()));
                },child: Text('Login',style: TextStyle(color: Colors.white),),enableFeedback: true)),
            SizedBox(height: 50.0,),
            Material(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.blueAccent,
                child: MaterialButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>registration_screen()));
                },child: Text('Register',style: TextStyle(color: Colors.white),),enableFeedback: true))

        ],),
      )
    ),
    );
  }
}
