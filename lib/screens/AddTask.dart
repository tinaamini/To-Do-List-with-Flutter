//........imports......
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../models/category.dart';
import '../services/api_service.dart';


class AddTask extends StatefulWidget {
  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  String _title = "Categories";
  List<Category> categories = [];
  final FocusNode _focusNode = FocusNode();
  Color _labelColor = Colors.black;
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  int? _selectedCategory;


  // -----initState----------------
  @override
  void initState() {
    super.initState();
    loadCategories();
    _focusNode.addListener(() {
      setState(() {
        _labelColor = _focusNode.hasFocus ? Colors.grey : Colors.black;
      });
    });
  }

//------------futures---------------
  Future<void> loadCategories() async {
    try {
      final data = await Service.fetchCategories();
      setState(() {
        categories = data.map((item) => Category.fromJson(item)).toList();
        if (categories.isNotEmpty) {
          _title = categories[0].name;
        }
      });
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }


  Future<void> addCategory(String name) async {
    await Service.sendDataToApi(name);
    await loadCategories();
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> _addTask() async {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();

    if (title.isEmpty || description.isEmpty || _selectedCategory == null) {
      _showError("All fields are required");
      return;
    }
   

    try {
      await Service().createTask(title, description, _selectedCategory!);
      print("Task successfully added!");
      Navigator.pop(context); //
    } catch (e) {
      _showError("Error adding task: $e");
    }
  }



  // -----------------dispose-------------
  @override
  void dispose() {
    _controller.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:ListView(
        children: [Container(
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
                    // ----------------------categories
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
                                _title,
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
                            onChanged: (value) {
                              setState(() {
                                _title = value;
                              });
                            },
                          ),
                        ),
                  SizedBox(
                    height: 200,
                    child:categories.isEmpty
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('No categories available.'),
                              )
                            : ListView(
                                children: categories
                                    .map((category) => ListTile(
                                          title: Text(category.name),
                                          trailing: IconButton(onPressed:(){
                                            Service.DeletCategory(category.id.toString());

                                            setState(() {
                                              categories.remove(category);

                                            });
                                          }, icon: Icon(Icons.highlight_remove,color: Colors.red,),),
                                          onTap: () {
                                            setState(() {
                                              _title = category.name;
                                              _selectedCategory = category.id;
                                            });
                                          },
                                        ))
                                    .toList(),
                              ),
                  ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),

                //-----------------text field task name
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 0,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          )
                        ]),
                    child: TextField(
                      controller: _titleController,
                      focusNode: _focusNode,
                      decoration: InputDecoration(
                        labelText: 'Task Name',
                        labelStyle: TextStyle(
                            color: _labelColor, fontWeight: FontWeight.w600),
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                //----------------------text field description

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    height: 180.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 0,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          )
                        ]),
                    child: TextField(
                      controller: _descriptionController,
                      focusNode: _focusNode,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        labelStyle: TextStyle(
                            color: _labelColor, fontWeight: FontWeight.w600),
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                    ),
                  ),
                ),
                // ----------------elevate button add
                SizedBox(height: 150,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    minimumSize: Size(331.0, 52.0),
                    backgroundColor: Color(0xFF774BF1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(25)),
                    ),
                  ),
                  onPressed: _addTask,
                  child: Text('add'),
                ),
              ],
            ),
          ),
        ),]
      ),
    )
    );
  }
}
