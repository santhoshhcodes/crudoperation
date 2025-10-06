import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'bot.dart';


class Sign extends StatefulWidget {
  const Sign({super.key});

  @override
  State<Sign> createState() => _SignState();
}

class _SignState extends State<Sign> {
  final valid = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool _enter = false;
  bool _view = true; //for Password

  visible(){
    setState(() {
      if(email.text.isNotEmpty && password.text.isNotEmpty){
        _enter = true;
      }else{
        _enter = false;
      }
    });
  }


  Sign_up() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text
    );
      Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(builder: (context) => Bot(   )), (route)=>false);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white12,

        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Sign in",style: TextStyle(fontWeight: FontWeight.bold,),),
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
               color: Colors.yellow[700],
            ),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: Container(
                    width: 320,
                    height: 350,
                    padding: EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withOpacity(0.3),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text("Sign in",style: TextStyle(
                              color: Colors.black54,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),),
                          SizedBox(height: 15,),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: TextFormField(
                              controller: email,
                              onChanged: (i){
                                visible();
                              },
                              validator: (value){
                                if(value == null || value.isEmpty){
                                  return"please Enter the Email";
                                }
                                if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!)){
                      
                                  return"Invalid Email";
                                }
                                return null;
                      
                              },
                              decoration: InputDecoration(
                                icon: Icon(Icons.person),
                                hintText: "Enter Your Email",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(height: 15,),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: TextFormField(
                              controller: password,
                              obscureText: _view,
                              onChanged: (i){
                                visible();
                              },
                              validator: (value){
                      
                                if (value==null || value.isEmpty){
                      
                                  return"Please enter the password";
                                }
                                if(!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(value!)){
                      
                                  return "Password must should be 8+"
                                      " characters and include letters,"
                                      " numbers, and a specail character.";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                icon: Icon(Icons.password),
                                hintText: "Enter Your Password",
                                border: OutlineInputBorder(),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(onPressed: ()=>setState(()=> _view = !_view),
                                      icon: Icon(_view? Icons.visibility_off :Icons.visibility)),
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
                                    // try {
                                      await Sign_up();
                                      Navigator.pushAndRemoveUntil(context,
                                        MaterialPageRoute(builder: (context) => Bot()),
                                            (route) => false,);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            "Thank You",
                                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                          backgroundColor: Colors.green,),);
                                    }
                                    // catch (e) {
                                    //   ScaffoldMessenger.of(context).showSnackBar(
                                    //     SnackBar(content: Text(
                                    //       "Signin Failed: ${e.toString()}",
                                    //       style: TextStyle(color: Colors.white),),
                                    //       backgroundColor: Colors.red,),);}
                                  },
                                // },
                                child: Text("Sign in", style: TextStyle(color: Colors.white)),
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                              ),
                            ],
                          ),
                          SizedBox(height: 28,),
                      
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
