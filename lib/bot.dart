

import 'package:flutter/material.dart';

import 'Home.dart';
import 'Float.dart';

class Bot extends StatefulWidget {
  const Bot({super.key});

  @override
  State<Bot> createState() => _BotState();
}


class _BotState extends State<Bot> {

  int _index =0;

  final Screen =[
    Float(),
    Home(),
  ];
  void tap(index){
setState(() {
  _index = index;
});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screen[_index],
      bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.note_add_rounded),label: "Note"),
            BottomNavigationBarItem(icon: Icon(Icons.upload),label: "Upload"),
          ],
    currentIndex: _index,
    onTap: tap,

    ),

    );
  }
}
