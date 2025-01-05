import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/task.dart';
import '../services/api_service.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'DetailPage.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<Task>> _tasks;
  int? _selectedIndex;
  Task? _selectedTask;

  void _toggleItem(int index) {
    setState(() {
      if (_selectedIndex == index) {
        _selectedIndex = null;
        _selectedTask = null;
      } else {
        _selectedIndex = index;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _tasks = Service.fetchTasks();
    // print(_tasks);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
        decoration: BoxDecoration(color: Colors.white),
    child: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 10.0, left: 10.0),
            child: Directionality(
              textDirection: TextDirection.ltr, // Directionality برای متن‌ها
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 60.0, bottom: 20.0),
                    child: Text(
                      'Home',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 260),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Edite',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w600),
                      ),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        minimumSize: Size(29.0, 37.0),
                        backgroundColor: Color(0xFF774BF1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  FutureBuilder<List<Task>>(
                    future: _tasks,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        return Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final task = snapshot.data![index];
                              return ListTile(
                                title: Container(
                                  height: 63.0,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFFDE4F3),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    border: Border(
                                      left: BorderSide(
                                        color: Color(0xFFF478B8),
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 5.0),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 15.0),
                                              child: SvgPicture.asset(
                                                'assets/svg/bag.svg',
                                                width: 26,
                                                height: 26,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 18.0),
                                              child: AutoSizeText(
                                                task.title,
                                                style: TextStyle(
                                                    fontFamily: 'Vazir',
                                                    color: Color(0xFFF478B8),
                                                    fontWeight:
                                                        FontWeight.w500),
                                                maxLines: 1,
                                                maxFontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              left: 195.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _toggleItem(index);
                                              });
                                              if (_selectedIndex == index) {
                                                Future.delayed(
                                                    Duration(seconds: 1), () {
                                                  if (_selectedIndex != null) {
                                                    _tasks.then((tasks) {
                                                      final selectedTask =
                                                          tasks[
                                                              _selectedIndex!];
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              DetailPage(
                                                                  task:
                                                                      selectedTask),

                                                        ),
                                                      );
                                                    });
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                            'Please select an item first!'),
                                                      ),
                                                    );
                                                  }
                                                });
                                              }
                                            },
                                            child: Stack(
                                              children: [
                                                Container(
                                                  width: 35,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                                if (_selectedIndex == index)
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 6.0,
                                                            left: 4.0),
                                                    child: SvgPicture.asset(
                                                      'assets/svg/selected.svg',
                                                      width: 24,
                                                      height: 24,
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ))
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
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 75.0, left: 15.0, right: 15.0),
                    child: Container(
                      height: 55.0,
                      decoration: BoxDecoration(
                        color: Color(0xFF774BF1),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                "Add Task",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),),
    );
  }
}
// if (_selectedIndex != null) {
// _tasks.then((tasks) {
// final selectedTask = tasks[_selectedIndex!];
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) =>
// Editepage(task: selectedTask),
// ),
// );
// });
// } else {
// ScaffoldMessenger.of(context).showSnackBar(
// SnackBar(
// content: Text('Please select an item first!'),
// ),
// );
// }
