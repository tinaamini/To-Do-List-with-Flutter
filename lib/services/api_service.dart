import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category.dart';

class ApiService {
  final String baseUrl = "http://127.0.0.1:8000";  // آدرس سرور FastAPI

  Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/categories'));


    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((category) => Category.fromJson(category)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
//------------------------badan jabejashon konm