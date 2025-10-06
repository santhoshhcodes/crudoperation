

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'bot.dart';
import 'login.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  var user = FirebaseAuth.instance.currentUser;
  @override
  void initState(){
    Future.delayed(Duration(seconds: 3),(){
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(
              builder: (context)=> Login()),(route)=>false);
      if(user != null){
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(
                builder: (context)=> Bot()),(route)=>false);
      }
      else{
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context)=> Login(),),(route)=>false
        );
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("CRUD",style: TextStyle(color: Colors.blue,fontSize: 28,fontWeight: FontWeight.bold),),
              Text(" list",style: TextStyle(),)
            ],
          ))
        ],
      ),
    );
  }
}
