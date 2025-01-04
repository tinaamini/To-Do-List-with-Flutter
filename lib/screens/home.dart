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
          child: Padding(
            padding: const EdgeInsets.only(right: 10.0,left: 10.0),
            child: Directionality(
              textDirection: TextDirection.ltr, // Directionality برای متن‌ها
              child: Column( // اضافه کردن یک Column
                children: [
                  // اینجا می‌توانید هر ویجت متنی یا ویجت‌های دیگر را اضافه کنید
                  Padding(
                    padding: const EdgeInsets.only(top: 60.0,bottom: 20.0),
                    child: Text(
                      'Home',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 260),
                    child: ElevatedButton(onPressed:(){}, child:Text('Edite'),
                      style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      minimumSize: Size(29.0, 29.0),
                      backgroundColor: Color(0xFF774BF1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(25)),
                      ),
                    ),),
                  )
                  ,
                  FutureBuilder<List<Task>>(
                    future: _tasks,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No tasks found.'));
                      } else {
                        return Expanded( // اضافه کردن Expanded برای استفاده بهینه از فضای Column
                          child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final task = snapshot.data![index];
                              return ListTile(
                                title: Container(
                                  decoration:BoxDecoration(
                                    color: Color(0xFFFFD9FD),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15)),
                                    border: Border(
                                      left: BorderSide(
                                        color:Color(0xFFFF25F4),
                                        width: 2.0,
                                      ),
                                    ),
                                  ),

                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/svg/bag.svg',
                                            width: 26,
                                            height: 26,
                                          ),
                                          Text(
                                            task.title,
                                            style: TextStyle(fontFamily: 'Vazir'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

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
}