import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/category.dart';
import '../models/task.dart';
import 'AddTask.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();

    tasks.add(Task(
      id: 1,
      title: "Task 1",
      description: "This is a description of Task 1",
      isCompleted: false,
      createdAt: "2025-01-01",
      updatedAt: "2025-01-01",
      category: Category(id: 1, name: "Work"),
    ));
    tasks.add(Task(
      id: 2,
      title: "Task 2",
      description: "This is a description of Task 2",
      isCompleted: true,
      createdAt: "2025-01-02",
      updatedAt: "2025-01-02",
      category: Category(id: 2, name: "Personal"),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.white,
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

              Expanded(
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    Task task = tasks[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFFD1D1D1),
                              blurRadius: 4,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: ListTile(
                          title: Text(
                            task.title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                task.description,
                                style: TextStyle(fontSize: 14),
                              ),
                              Text(
                                'Category: ${task.category.name}',
                                style: TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                              Text(
                                'Created: ${task.createdAt}',
                                style: TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                              Text(
                                'Updated: ${task.updatedAt}',
                                style: TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                              Text(
                                task.isCompleted ? 'Completed' : 'Pending',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: task.isCompleted ? Colors.green : Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 35.0, left: 25.0, right: 25.0),
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
                      borderRadius: BorderRadius.all(Radius.circular(25)),
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
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                      SvgPicture.asset(
                        'assets/svg/IconAdd.svg',
                        width: 24,
                        height: 24,
                      ),
                    ],
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