import 'package:flutter/material.dart';


class Route extends StatefulWidget {
  String nextPage;
  Route({super.key,required this.nextPage});

  @override
  State<Route> createState() => _RouteState();
}

class _RouteState extends State<Route> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(15),
              bottomLeft: Radius.circular(15),
            )
        ),
        title: Text("details"),
      ),
      body: Text(widget.nextPage),
    );
  }
}
