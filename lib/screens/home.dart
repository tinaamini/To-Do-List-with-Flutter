import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/task.dart';
import '../services/api_service.dart';
import 'AddTask.dart';



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
        body: FutureBuilder<List<Task>>(
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
                    title: Text(task.title),


                  );
                },
              );
            }
          },
        ),

        // Container(
        //   color: Colors.white,
        //   child: Column(
        //     children: [
        //       Padding(
        //         padding: const EdgeInsets.only(top: 35.0),
        //         child: Text(
        //           'Home',
        //           style: TextStyle(
        //             fontSize: 19,
        //             color: Color(0xFF000000),
        //             fontWeight: FontWeight.w800,
        //           ),
        //         ),
        //       ),
        //
        //       // listview
        //
        //
        //
        //
        //       Padding(
        //         padding: const EdgeInsets.only(bottom: 35.0, left: 25.0, right: 25.0),
        //         child: ElevatedButton(
        //           onPressed: () {
        //             Navigator.push(
        //                 context, MaterialPageRoute(builder: (context) => AddTask()));
        //
        //           },
        //           style: ElevatedButton.styleFrom(
        //             foregroundColor: Colors.white,
        //             minimumSize: Size(331.0, 52.0),
        //             backgroundColor: Color(0xFF774BF1),
        //             shape: RoundedRectangleBorder(
        //               borderRadius: BorderRadius.all(Radius.circular(25)),
        //             ),
        //           ),
        //           child: Row(
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
    );
  }
}