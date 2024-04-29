import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:monumental_habits/models.dart';
import 'package:provider/provider.dart';

import '../services/course_service.dart';
import '../entities/course.dart';
import '../widgets/app_bar.dart';

class CoursesPage extends StatelessWidget {
  static CourseService courseService = const CourseService();

  const CoursesPage({super.key});

  FutureBuilder<Course> getCourseTile(int id) {
    return FutureBuilder<Course>(
      future: courseService.fetchCourse(id),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return CourseTile(snapshot.data!);
        } else {
          return const CircularProgressIndicator();
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Consumer<ThemeNotifier>(
              builder: (context, theme, child) {
                return Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        "lib/images/Homepage.png",
                        fit: BoxFit.fitWidth,
                      ),
                      Container(
                        color: Colors.black.withOpacity(theme.isDarkTheme ? 0.5 : 0),
                      )
                    ]
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 100,),
                getCourseTile(1),
                getCourseTile(2),
                getCourseTile(3),
                getCourseTile(4)
              ],
            ),
          ),
          Column(
            children: [
              MyAppBar(
                leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
                title: 'Courses',
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
        ],
      ),
    );
  }
}

class CourseTile extends StatelessWidget {
  final Course course;

  const CourseTile(this.course, {super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, theme, child) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              color: theme.primaryColor,
              height: 100,
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Course ${course.id}", style: TextStyle(color: theme.textColor, fontSize: 20),),
                  const SizedBox(height: 5,),
                  Text(course.title, style: TextStyle(color: theme.textColor),),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

