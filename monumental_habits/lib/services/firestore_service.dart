import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:monumental_habits/services/converter.dart';
import '../entities/habit.dart';

class FirestoreService {

  static final CollectionReference habits =
      FirebaseFirestore.instance.collection('habits');

  static Map<String, bool> convertDateTimeMapToString(Map<DateTime, bool> dateTimeMap) {
    return dateTimeMap.map((key, value) {
      String keyString = Converter.datetimeToString(key);
      return MapEntry(keyString, value);
    });
  }

  static Map<DateTime, bool> convertStringToDateTimeMap(Map<String, bool> dateTimeMap) {
    return dateTimeMap.map((key, value) {
      return MapEntry(DateTime.parse(key), value);
    });
  }

  static Future<void> addHabit(Habit habit) {
    return habits.add({
      'name': habit.name,
      'color': habit.color.value,
      'wasDone': convertDateTimeMapToString(habit.wasDone),
      'timestamp': Timestamp.now()
    });
  }

  static Stream<QuerySnapshot> getHabitsStream() {
    return habits.orderBy('timestamp', descending: false).snapshots();
  }

  static Future<void> updateHabit(String docID, Habit habit) {
    return habits.doc(docID).update({
      'name': habit.name,
      'color': habit.color.value,
      'wasDone': convertDateTimeMapToString(habit.wasDone),
    });
  }

  static Future<void> nextDay() {
    return habits.get().then(
      (QuerySnapshot snapshot) {
        // for (var doc in snapshot.docs) {
        //   Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        //
        //   // List<bool> newWasDone = [...data['wasDone']];
        //   // newWasDone.add(false);
        //
        //   Map<DateTime, bool> oldWasDone = data['wasDone'] as Map<DateTime, bool>;
        //
        //   print("");
        //   print("");
        //   print(oldWasDone.toString());
        //   print("");
        //   print("");
        //
        //   Map<DateTime, bool> newWasDone = {...oldWasDone, DateTime.now(): false};
        //
        //   updateHabit(doc.id, Habit(
        //     name: data['name'],
        //     color: Color(data['color'] as int),
        //     wasDone: newWasDone,
        //   ));
        // }
      }
    );
  }

}