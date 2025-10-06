import 'package:flutter/material.dart';

class Themeref extends StatefulWidget {
  const Themeref({super.key});

  @override
  State<Themeref> createState() => _ThemerefState();
}
bool show = true;

class _ThemerefState extends State<Themeref> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: show? ThemeData.dark():ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Theme"),
          actions: [
            IconButton(onPressed: (){
              setState(() {
                show = !show;
              });
            }, icon: Icon(show ? Icons.light_mode : Icons.dark_mode),)
          ]

        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text("hello"),
          ],
        ),
      ),
    );
  }
}
