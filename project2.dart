/* Створити застосунок на Dart, в якому продемонструвати:
+ 1) Оператори "синтаксичного цукру". Наприклад оператор "??=" 
+ 2) Використання лямбда-функцій, замикань 
+ 3) Використання параметрів за замовчуванням 
+ 4) Різні варіанти конструкторів: 
    + 4.1) Фабричний конструктор
    + 4.2) Конструктор ініціалізації 
+ 5) Використання міксинів 
+ 6) Використання ключового слова assert 
+ 7) Робота з різними типами колекцій. */

const String NO_MENTOR_TEXT = "[absent]";
const String NO_INFORMATION_TEXT = "[none]";

const String EMAIL_SUBJECT = "Subject: Assistance Needed (Project Issue)";
const String EMAIL_TEMPLATE =
    "\nI'm facing a challenge with our project and could use your expertise to overcome it. Despite my efforts, I'm unable to find a solution.";

const List<String> PRESENTATION_SUBTASKS = [
  "Prepare data",
  "Create a desigh",
  "Rehearse the presentation"
];

void main() {
  // Outputs anything related to classes and functions for this codelab
  studyProjects();
  workProjects();
  taskFactory();
  closure();

  // Outputs anything related to collections
  lists();
  sets();
  maps();
}

void studyProjects() {
  print("\n-- WORKING WITH STUDY PROJECTS --");

  var task = StudyProject("Prepare for exam", Priority.high,
      subject: "Linear Algebra", isFinished: true);

  print("\n➦ Task info (not full):");
  print(task.getInfo());

  print("\n➦ Task status:");
  print(task.getStatus());

  task.priority = Priority.low;
  print("\n➦ Changed task's priority from high to low." +
      " Also full info is being displayed.");

  task.getInfo();
  task.printFullInfo();

  print("\n➦ Creating guided study project:");
  var taskGuided =
      StudyProject.guided("Course Work - OOP", Priority.high, "O. Krush");
  taskGuided.printFullInfo();
}

void workProjects() {
  print("\n-- WORKING WITH WORK PROJECTS --");

  var task2 =
      WorkProject("Work Task 1", Priority.low, department: "Marketing & Sales");

  print("\n➦ Task info:");
  print(task2.getInfo());

  print("\n➦ Task info (full):");
  task2.printFullInfo();

  print("\n➦ Adding subtasks to the project. Task info (full):");
  task2.subtasks = ["subtask 1", "subtask 2"];
  task2.printFullInfo();

  print("\n➦ New Task - Presentation:");
  var task3 = WorkProject.presentation("Make a presentation", Priority.medium);
  task3.department = "Finance";
  task3.printFullInfo();
}

void taskFactory() {
  print("\n-- WORKING WITH FACTORY CONSTRUCTOR --");

  print("\n➦ Paid (work) project:");
  var paidProject = Task.universityPractice("GIS in energy systems", true);
  assert(paidProject is WorkProject);
  (paidProject as WorkProject).printFullInfo();

  print("\n➦ Unpaid (study) project:");
  var unpaidProject = Task.universityPractice("Mobile Development", false);
  assert(unpaidProject is StudyProject);
  (unpaidProject as StudyProject).printFullInfo();
}

void closure() {
  print("\n-- WORKING WITH CLOSURE --");

  const String issue =
      "In ArcGIS, half of the panels and buttons are grey and unclickable.";

  print("\n➦ Creating an email about some issue that poped up in project:");
  var emailMrWhite = createEmailer("White");
  String emailText1 = emailMrWhite(issue, "Veronika Zelinska");
  print(emailText1);
}

void lists() {
  print("\n-- WORKING WITH LISTS --");

  void printList(List<String> list) {
    for (var el in list) print("- $el");
  }

  // list of names for tasks/projects
  var quickTODOList = ["Lecture 3", "Soc. Psychology essey"];

  print("\n➦ Quick TO-DO list:");
  printList(quickTODOList);

  print("\n➦ Quick TO-DO list (extended with spread operator):");
  var insertedList = ["Eng. p. 104", "Bio. workshop"];
  quickTODOList.addAll(["OOP lab 3", ...insertedList, "PE test"]);
  printList(quickTODOList);

  print("\n➦ TO-DO list with only short-named tasks:");
  var shortTaskNames = [
    "SORT TASKS",
    for (var task in quickTODOList)
      if (task.length <= 10) task,
    "CLEAN LIST"
  ];
  printList(shortTaskNames);
}

void sets() {
  print("\n-- WORKING WITH SETS --");

  void printSet(Set<String> list) {
    for (var el in list) print("- $el");
  }

  // it lets you put in it a duplicate, but automatically deletes it
  print("\n➦ Unique TO-DO list:");
  var uniqueTODO = {"OOP lab 3", "DB lab 3", "OOP lab 3"};
  printSet(uniqueTODO);

  assert(uniqueTODO.length == 2);

  // also we can add not only sets, but any Iterable<String>
  // And! It adds only unique elements
  print("\n➦ Added list's elements:");
  var someList = ["one element", "one element"];
  uniqueTODO.addAll(someList);
  printSet(uniqueTODO);
}

void maps() {
  print("\n-- WORKING WITH MAPS --");

  void printMap(Map<String, String> map) {
    for (var key in map.keys) print("- $key -> ${map[key]}");
  }

  print("\n➦ Map (Subject -> Homework):");
  var homework = {"Math": "lecture 2", "GIS": "lab 1"};
  printMap(homework);

  assert(homework.length == 2);

  print("\n➦ Inserted constant map:");
  final insertedMap = const {"PE": "test", "English": "SB p. 156"};
  homework.addAll(insertedMap);
  printMap(homework);
}

// Returns a function that creates an email text, asking mentor for help.
Function createEmailer(String mentor) {
  if (mentor == NO_MENTOR_TEXT) return () => null;
  return (String issue, String senderName) => "$EMAIL_SUBJECT\n\n"
      "Dear Professor $mentor,"
      "$EMAIL_TEMPLATE $issue\n\n"
      "Thank you,\n$senderName";
}

enum Priority { low, medium, high }

mixin ShowInfo on Task {
  // lambda function + ternar operators
  String getStatus() => isFinished ? "It's done." : "Still working on it.";

  String getInfo() {
    String priorityDisplay;

    switch (priority) {
      case Priority.high:
        priorityDisplay = "★★★";
      case Priority.medium:
        priorityDisplay = "★★☆";
      default:
        priorityDisplay = "★☆☆";
    }

    // cascade
    var sb = StringBuffer()
      ..write('"$name" ')
      ..write("[$priorityDisplay] ")
      ..write('is ${(isFinished ? "" : "not ")}finished.');

    return sb.toString();
  }
}

class Task {
  String name = "Task";
  Priority priority = Priority.low;
  bool isFinished = false;

  Task(this.name, this.priority, {bool isFinished = false});

  // Factory constructor
  factory Task.universityPractice(String subject, bool isForPaidPractice) {
    return isForPaidPractice
        ? WorkProject("Practice Project", Priority.high)
        : StudyProject("Practice Project", Priority.high, subject: subject);
  }
}

class StudyProject extends Task with ShowInfo {
  String subject = "";
  String mentor = "";

  StudyProject(super.name, super.priority,
      {String subject = NO_INFORMATION_TEXT,
      String mentor = NO_MENTOR_TEXT,
      bool isFinished = false}) {
    super.isFinished = isFinished;
    this.subject = subject;
    this.mentor = mentor;
  }

  // Redirecting constructor
  StudyProject.guided(String name, Priority priority, String mentor)
      : this(name, priority, subject: "Practice", mentor: mentor);

  void printFullInfo() {
    print(getInfo() + "\nSubject: $subject\nMentor: $mentor");
  }
}

class WorkProject extends Task with ShowInfo {
  String department = "";
  List<String>? subtasks = null;

  WorkProject(super.name, super.priority,
      {String department = NO_INFORMATION_TEXT,
      List<String>? subtasks,
      bool isFinished = false}) {
    super.isFinished = isFinished;
    this.department = department;
    this.subtasks = subtasks;
  }

  // Constructor with initializer list
  WorkProject.presentation(
    super.name,
    super.priority,
  ) : subtasks = PRESENTATION_SUBTASKS;

  void printFullInfo() {
    print(getInfo() +
        "\nDepartment: $department\nSubtasks: ${subtasks ?? NO_INFORMATION_TEXT}");
  }
}
