import 'package:cloud_firestore/cloud_firestore.dart';
import '../entities/habit.dart';

class FirestoreService {

  static final CollectionReference habits =
      FirebaseFirestore.instance.collection('habits');

  static Future<void> addHabit(Habit habit) {
    return habits.add({
      'name': habit.name,
      'color': habit.color.value,
      'wasDone': habit.wasDone,
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
      'wasDone': habit.wasDone,
    });
  }

  // static Future<void> nextDay() {
  //   return habits.get().then(
  //     (QuerySnapshot snapshot) {
  //       for (var doc in snapshot.docs) {
  //         Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  //
  //         // List<bool> newWasDone = [...data['wasDone']];
  //         // newWasDone.add(false);
  //
  //         Map<DateTime, bool> oldWasDone = data['wasDone'] as Map<DateTime, bool>;
  //
  //         print("");
  //         print("");
  //         print(oldWasDone.toString());
  //         print("");
  //         print("");
  //
  //         Map<DateTime, bool> newWasDone = {...oldWasDone, DateTime.now(): false};
  //
  //         updateHabit(doc.id, Habit(
  //           name: data['name'],
  //           color: Color(data['color'] as int),
  //           wasDone: newWasDone,
  //         ));
  //       }
  //     }
  //   );
  // }

}