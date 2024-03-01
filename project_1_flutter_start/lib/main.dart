import 'package:flutter/material.dart';

/* Tasks for project 1:
 * + My name & surname written somewhere
 * + Usage of constructors
 * + Usage of named parameters
 * + Usage of private fields
 * + Usage of getters & setters
 */
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  static const String creator = "Zelinska Veronika";

  //TODO: uncomment one of these:
  // final project1 = Project.ordered("Flutter start");
  final project1 = Project("Third project", 3);

  //TODO: delete minus / comment this line
  // project1.currentProjectNumber = -55;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.teal.shade50,
        appBar: AppBar(
          title: const Text(creator),
          backgroundColor: Colors.teal[200],
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        ),
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: Colors.teal.shade200,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [BoxShadow(
                color: Colors.black26,
                spreadRadius: 2,
                blurRadius: 15,
                offset: Offset(0, 3),
              )]
            ),
            child: Text(
              //TODO: with or without optional named argument
              project1.getDescription(note: "Here's my project  ┐(´•_•`)┌"),
              // project1.getDescription(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Project {
  final String creator = "Zelinska Veronika";
  static int _projectNumber = 0;
  int _currentProjectNumber = 0;
  String projectName = "[no info]";

  Project(this.projectName, this._currentProjectNumber);

  // named constructors
  Project.ordered(this.projectName) {
    _currentProjectNumber = ++_projectNumber;
  }

  String getDescription({String? note})  {
    var description =
        "Creator: $creator\n"
        "Name: $projectName\n"
        "Order number: $_currentProjectNumber";

    return description + (note == null ? "" : "\nNote: $note") ;
  }

  int get currentProjectNumber => _currentProjectNumber;
  set currentProjectNumber(int num) {
    _currentProjectNumber = (num <= 0) ? -1 : num;
  }
}
