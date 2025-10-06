import 'package:flutter/material.dart';

import 'bot.dart';

class Result extends StatefulWidget {
  String Next;
  Result({super.key,required this.Next});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    List<String> parts = widget.Next.split('|');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(onPressed: (){
          setState(() {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder)=>Bot()), (route)=>false);
          });
        },
          icon: Icon(Icons.arrow_back_ios,color: Colors.white,)

      ),
        title: Text("Details",style: TextStyle(color: Colors.white),),
      ),

      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.blue[200]
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 150,),
              Center(
                child: Container(
                    height: 200,
                    width: 330,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Hello ",style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25),),
                                Expanded(
                                  child: Text("${parts[0]}",style: TextStyle(
                                      color: Colors.blue[900],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),),
                                ),
                              ],
                            ),
                          ),
                          Column(
                             crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                             SizedBox(height: 10,),
                             Table(
                               columnWidths: const {
                                 0: IntrinsicColumnWidth(),
                                 1: FlexColumnWidth(),
                               },
                               children: [
                                 TableRow(
                                     children: [
                                       Text("Password",style: TextStyle(fontSize: 18,color: Colors.black),),
                                       Text("  :  ${parts[1]}",style: TextStyle(fontSize: 18,color: Colors.black),),
                                     ]
                                 ),

                                 TableRow(
                                     children: [
                                       Text("Email",style: TextStyle(fontSize: 18,color: Colors.black),),
                                       Text("  :  ${parts[2]}",style: TextStyle(fontSize: 18,color: Colors.black),),
                                     ]
                                 ),
                                 TableRow(
                                     children: [
                                       Text("Mobile no",style: TextStyle(fontSize: 18,color: Colors.black),),
                                       Text("  :  ${parts[3]}",style: TextStyle(fontSize: 18,color: Colors.black),),
                                     ]
                                 ),
                               ],
                             )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
              ),
                
                
            ],
          ),
        ),
      ),
    );
  }
}

