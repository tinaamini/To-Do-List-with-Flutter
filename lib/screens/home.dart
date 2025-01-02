import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todolist_front/screens/AddTask.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {
  List<String> tasks = [];

  void addTask(String task) {
    setState(() {
      tasks.add(task);
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 35.0),
            child: Text(
              'Home',
              style: TextStyle(
                fontSize: 19,
                color: Color(0xFF000000),
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 108.0, left: 25.0, right: 25.0,    ),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => AddTask()));
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                minimumSize: Size(331.0, 52.0),
                backgroundColor: Color(0xFF774BF1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(25)),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      "Add Task",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1),
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/svg/IconAdd.svg',
                    width: 24,
                    height: 24,
                  )

                ],
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }
}
