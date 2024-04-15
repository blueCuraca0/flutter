import 'dart:convert';

import 'package:http/http.dart' as http;

class Course {
  String id;
  String title;

  Course(this.id, this.title);

  static Future<Course> fetchCourse(int jsonId) async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/$jsonId'));

    if (response.statusCode == 200) {
      return Course.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load a course');
    }
  }

  factory Course.fromJson (Map<String, dynamic> json) {
    return Course(
      '${json['id']}.${json['userId']}',
      json['title'],
    );
  }
}
