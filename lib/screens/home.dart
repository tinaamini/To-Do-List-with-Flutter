import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/task.dart';
import '../services/api_service.dart';
import 'AddTask.dart';
import 'package:http/http.dart' ;


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<Task>> _tasks;

  @override
  void initState() {
    super.initState();
    _tasks = Service.fetchTasks();
    print(_tasks);


  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Directionality(
          textDirection: TextDirection.ltr,
          child:FutureBuilder<List<Task>>(

            future: _tasks,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No tasks found.'));
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final task = snapshot.data![index];
                    return ListTile(
                      title: Column(
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/svg/bag.svg',
                                width: 26,
                                height: 26,
                              ),
                              Text(task.title ,style: TextStyle(fontFamily: 'Vazir'),),
                            ],
                          )
                        ],
                      ),


                    );
                  },
                );
              }
            },
          ),
        ),

      // Row(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               Expanded(
        //                 child: Text(
        //                   "Add Task",
        //                   textAlign: TextAlign.center,
        //                   style: TextStyle(
        //                     fontSize: 20,
        //                     fontWeight: FontWeight.w800,
        //                     letterSpacing: 1,
        //                   ),
        //                 ),
        //               ),
        //               SvgPicture.asset(
        //                 'assets/svg/IconAdd.svg',
        //                 width: 24,
        //                 height: 24,
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ),
    ));
  }
}