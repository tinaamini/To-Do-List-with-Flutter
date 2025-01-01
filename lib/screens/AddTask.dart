import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../models/category.dart';
import 'package:http/http.dart' as http;



class AddTask extends StatefulWidget {
  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  List<Category> categories = [];
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    final response =
    await http.get(Uri.parse('http://127.0.0.1:8000/categories'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        categories = data.map((item) => Category.fromJson(item)).toList();
      });
    } else {
      throw Exception('Failed to load categories');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 65.0),
                  child: Text(
                    'Add Task',
                    style: TextStyle(
                      fontSize: 19,
                      color: Color(0xFF000000),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(top: 25.0, left: 20.0, right: 20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ExpansionTile(
                      title: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/svg/bag.svg',
                            width: 26,
                            height: 26,
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Task Group',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'Work',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              hintText: 'Type something...',
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.grey[100],
                            ),
                          ),
                        ),
                        categories.isEmpty
                            ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('No categories available.'),
                        )
                            : Column(
                          children: categories
                              .map((category) => ListTile(
                            title: Text(category.name),
                          ))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
