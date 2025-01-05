import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/task.dart';


class Service {
  static const String _baseUrl = 'http://192.168.139.236:8000';


  // add new category
  static Future<void> sendDataToApi(String name) async {
    final url = Uri.parse('$_baseUrl/new-category');
    final response = await http.post(
      url,
      headers: {
        "accept": "application/json",
        "Content-Type": "application/json"
      },
      body: jsonEncode({"name": name}),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      print(responseData['message']);
    } else {
      print("Failed to send data.");
    }
  }
  // fetchCategories
  static Future<List<dynamic>> fetchCategories() async {
    final url = Uri.parse('$_baseUrl/categories');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load categories');
    }
  }

  // add new task
   Future<void> createTask(String title, String description, int categoryId) async {
    final url = Uri.parse('$_baseUrl/new-task'); // آدرس API
    final response = await http.post(
      url,
      headers: {
        "accept": "application/json",
        "Content-Type": "application/json"
      },
      body: jsonEncode({
        "title": title,
        "description": description,
        "category_id": categoryId,
      }),
    );

    if (response.statusCode == 200) {
      print("Task created successfully!");
      print(response.body);
    } else {
      print("Failed to create task. Status code: ${response.statusCode}");
      print(response.body);
    }
  }
  static Future<List<Task>> fetchTasks() async {
    final response = await http.get(Uri.parse('$_baseUrl/tasks'));

    if (response.statusCode == 200) {
      print('Data received: ${utf8.decode(response.bodyBytes)}');
      List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
      return data.map((task) => Task.fromJson(task)).toList();

    } else {
      throw Exception('Failed to load tasks');
    }
  }


}




