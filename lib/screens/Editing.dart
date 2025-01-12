import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../models/task.dart';
import '../services/api_service.dart';

class EditDetailPage extends StatefulWidget {
  final Task task;

  EditDetailPage({required this.task});

  @override
  _EditDetailPageState createState() => _EditDetailPageState();
}

class _EditDetailPageState extends State<EditDetailPage> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _createdAtController;
  late TextEditingController _updatedAtController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _descriptionController =
        TextEditingController(text: widget.task.description);
    _createdAtController = TextEditingController(text: widget.task.createdAt);
    _updatedAtController = TextEditingController(text: widget.task.updatedAt);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _createdAtController.dispose();
    _updatedAtController.dispose();
    super.dispose();
  }

  void _saveChanges() async {
    Task updatedTask = Task(
      id: widget.task.id,
      title: _titleController.text,
      description: _descriptionController.text,
      category: widget.task.category,
      createdAt: widget.task.createdAt,
      // تاریخ تغییر نمی‌کند
      updatedAt: DateTime.now().toString(),
      // به‌روزرسانی تاریخ
      isCompleted: widget.task.isCompleted,
    );

    await Service.updatedTask(
      updatedTask.id.toString(), // taskId
      updatedTask.title, // title
      updatedTask.description, // description
      updatedTask.category.id,
    );

    Navigator.pop(context, updatedTask);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Center(


              child: SingleChildScrollView(
                child: Column(
                    children: [
                Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  height: 100.0,
                  width: 350.0,
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Task Name',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextField(
                          controller: _titleController,
                          decoration: InputDecoration(
                            hintText: 'Enter task name',
                            border: InputBorder
                                .none, // No border for a more custom style
                          ),
                        ),
                      ],
                    ),
                  ),
                ),),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  height: 100.0,
                  width: 350.0,
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Task Name',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextField(
                          controller: _descriptionController,
                          decoration: InputDecoration(
                            hintText: 'Enter task name',
                            border: InputBorder
                                .none, // No border for a more custom style
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),

              SizedBox(height: 20),

              GestureDetector(
                onTap: () {
                  _saveChanges();
                },

                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                  child: Container(
                    height: 55.0,
                    decoration: BoxDecoration(
                      color: Color(0xFF774BF1),
                      borderRadius:
                      BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              "Save Changes",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )


          ],
        )
        ),
      ),
    ),)
    );

  }
}
