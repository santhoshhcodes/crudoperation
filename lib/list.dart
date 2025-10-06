import 'package:flutter/material.dart' hide Route;
import 'Route.dart';


class Listt extends StatefulWidget {
  const Listt({super.key});

  @override
  State<Listt> createState() => _ListtState();
}

class _ListtState extends State<Listt> {
  final ctrl1 = TextEditingController();
  final ctrl2 = TextEditingController();

  List out = [];



  route(String data){
    setState(() {

    });
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Route(nextPage: data,))).
    then((edit)
    {
      setState(() {
        out[out.indexWhere((element)=>element==data)]=edit;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("List",style: TextStyle(color: Colors.white),),
      ),
      body: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),

            child: TextFormField(
              maxLines: null,
              controller: ctrl1,
              decoration: InputDecoration(
                labelText: "Enter",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),


              ),
            ),
          ),
         ElevatedButton(onPressed: (){
              setState(() {
                out.add(ctrl1.text);

                print(out);

              });

            }, child: Text("enter")),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 400,
              width: 400,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(25),

              ),
                child: ListView.builder(
                  itemCount: out.length,
                    itemBuilder: (BuildContext,index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: GestureDetector(
                          onTap: (){
                            route(out[index]);
                          },
                          child: Row(


                              children: [
                              Padding(

                                padding: const EdgeInsets.all(8.0),
                                child: Text(out[index],style: TextStyle(color: Colors.white),
                                  overflow: TextOverflow.ellipsis, // trims the text if too long
                                  maxLines: 1,),

                              ),

                              GestureDetector(
                                onTap: (){
                                  showDialog(context: (context), builder: (BuildContext){
                                    return AlertDialog(
                                      content: SingleChildScrollView(
                                        child: TextFormField(
                                          controller: ctrl2,
                                          decoration: InputDecoration(
                                            labelText: "Edit",
                                          ),

                                        ),
                                      ),
                                      actions: [
                                        OutlinedButton(onPressed: (){
                                          setState(() {
                                            out[index] = ctrl2.text;
                                            Navigator.pop(context);
                                          });
                                        }, child: Text("Change"))
                                      ],
                                    );
                                  });
                                },
                                child: Icon(Icons.edit,color: Colors.white,),
                              ),
                                SizedBox(width: 10,),
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    out.removeAt(index);
                                  });
                                },
                                child: Icon(Icons.delete,color: Colors.white,),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                    })
              ),
            ),


        ],
      )),
    );
  }
}


