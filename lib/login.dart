import 'dart:ui';

import 'package:google_sign_in/google_sign_in.dart';

import 'package:crudoperation/sign.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Home.dart';
import 'bot.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}
final valid = GlobalKey<FormState>();

class _LoginState extends State<Login> {
  TextEditingController Email = TextEditingController();
  TextEditingController Pass = TextEditingController();

  Log_in() async
  {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: Email.text,
        password: Pass.text
    );

    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Home()), (route)=>false );

  }

  Future<User?> signInWithGoogle(BuildContext context) async {
    try {
      // This works for both web and mobile, but primarily designed for web
      GoogleAuthProvider googleProvider = GoogleAuthProvider();

      UserCredential userCredential = await FirebaseAuth.instance.signInWithPopup(googleProvider);

      final user = userCredential.user;
      if (user != null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Bot()),
              (route) => false,
        );
      }

      return user;
    } catch (e) {
      print("Google Sign-in error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Sign-in failed: ${e.toString()}"),
          backgroundColor: Colors.red,
        ),
      );
      return null;
    }
  }


  bool _enter  = false;//  for A LOGIN
  bool _view = true; //for Password
  visible(){
    setState(() {
      if(Email.text.isNotEmpty && Pass.text.isNotEmpty){
        _enter = true;
      }else{
        _enter = false;
      }
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.white12,

        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("login",style: TextStyle(fontWeight: FontWeight.bold,),),
        ),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: Icon(Icons.login,size: 25,),
        //   )
        // ],
      ),
      body:Form(
        key: valid,
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,

            ),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2
                      , sigmaY: 2),
                  child: Container(
                    width: 330,
                    height:400,
                    padding: EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(),
                  
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text("Login",style: TextStyle(
                              // color: Colors.black54,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),),
                          SizedBox(height: 15,),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: TextFormField(
                              controller: Email,
                              onChanged: (i){
                                visible();
                              },
                              validator: (value){
                                if(value == null || value.isEmpty){
                                  return"please Enter the Email";
                                }
                                return null;
                  
                              },
                              decoration: InputDecoration(
                                icon: Icon(Icons.person),
                  
                                hint: Text("Enter Your Email"),
                                border: OutlineInputBorder(),
                  
                              ),
                            ),
                          ),
                          SizedBox(height: 15,),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: TextFormField(
                              controller: Pass,
                              obscureText: _view,
                              onChanged: (i){
                                visible();
                              },
                                validator: (value){
                  
                                  if (value==null || value.isEmpty){
                  
                                    return"Please enter the password";
                                  }
                                  return null;
                  
                                },
                              decoration: InputDecoration(
                                  icon: Icon(Icons.password),
                                  hintText: "Enter Your Password",
                                  border: OutlineInputBorder(),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(onPressed: ()=>setState(() => _view = !_view),
                                      icon: Icon(_view ? Icons.visibility_off : Icons.visibility)),
                                )
                  
                              ),
                            ),
                          ),
                          SizedBox(height: 25,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                onPressed: () async {
                                  if (valid.currentState!.validate()) {
                                    try {
                                      await Log_in();
                                       Navigator.pushAndRemoveUntil(context,
                                         MaterialPageRoute(builder: (context) => Bot()),
                                             (route) => false,);
                                       ScaffoldMessenger.of(context).showSnackBar(
                                         SnackBar(
                                           content: Text(
                                             "Thank You",
                                             style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                           backgroundColor: Colors.green,),);
                                    } catch (e) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(
                                          "Login Failed: ${e.toString()}",
                                          style: TextStyle(color: Colors.white),),
                                          backgroundColor: Colors.red,),);}
                                  }
                                  },
                                  child: Text("Login", style: TextStyle(color: Colors.white)),
                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                                ),
                                ElevatedButton(onPressed: () async {
                                  final user = await signInWithGoogle(context);
                                  if (user != null) { // Navigate to home on successful login
                                    Navigator.pushReplacement(
                                        context, MaterialPageRoute(builder: (context) => Bot()));
                                  }
                                },
                                    child: Text("Google signin",
                                      style: TextStyle(color: Colors.white),),
                                    style:ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blueAccent[400])),
                              ],
                            ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                           Text("if you don't have the Account?",
                                style: TextStyle(),),
                              TextButton(onPressed: (){
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context)=> Sign()));
                              }, child: Text("Signin",
                                style: TextStyle(color: Colors.red,fontSize: 15),),),
                            ],
                          ),
                  
                  
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),


          ],
        ),
      ),

    );
  }
}
