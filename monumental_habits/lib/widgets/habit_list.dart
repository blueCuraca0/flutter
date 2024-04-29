import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:monumental_habits/services/converter.dart';
import 'package:provider/provider.dart';

import '../models.dart';
import '../constants/c_colors.dart';
import '../entities/habit.dart';
import '../screens/habit_info_screen.dart';
import '../services/firestore_service.dart';

const double squareSize = 50;

class HabitList extends StatelessWidget {
  final Size size;
  // final List<Habit> habits;

  const HabitList(this.size, {super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      child: SizedBox(
        width: size.width,
        child: StreamBuilder<QuerySnapshot>(
            stream: FirestoreService.getHabitsStream(),
            builder: (context, snapshot) {

              List habitList = snapshot.data?.docs ?? [];
              if (!snapshot.hasData) return const SizedBox();

              return ListView.builder(
                  itemCount: habitList.length + 2,
                  itemBuilder: (context, index) {
                    // 0 - header, [1, length] - habit tiles, length+1 - sized box
                    if (index == 0) {
                      return const HabitListHeader();
                    }
                    if (index == habitList.length + 1) {
                      return SizedBox(height: size.height / 5);
                    }

                    DocumentSnapshot document = habitList[index - 1];
                    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

                    // TODO: чомусь дає помилку "type 'List<dynamic>' is not a
                    // subtype of type 'List<bool>' in type cast
                    // List<bool> wasDONE = data['wasDone'] as List<bool>;

                    return HabitTile(Habit(
                        name: data['name'],
                        color: Color(data['color'] as int),
                        wasDone: {...data['wasDone']},
                        docID: document.id
                    ));
                  }
              );
            }
        ),
      ),
    );
  }
}

class HabitListHeader extends StatelessWidget {
  const HabitListHeader({super.key});

  String getWeekdayName(String stringDate, int daysPassed) {
    DateTime today = Converter.stringToDatetime(stringDate);
    DateTime givenDay = today.subtract(Duration(days: daysPassed));
    switch (givenDay.weekday) {
      case 1:
        return 'MON';
      case 2:
        return 'TUE';
      case 3:
        return 'WED';
      case 4:
        return 'THU';
      case 5:
        return 'FRI';
      case 6:
        return 'SAT';
      case 7:
        return 'SUN';
      default:
        return '???';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        left: 30,
        right: 30
      ),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Consumer<ThemeNotifier>(builder: (context, theme, child) {
                return Text(
                  "HABITS",
                  style: TextStyle(
                      color: theme.textColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 15),
                );
              }),
            ),
          ),
          Expanded(
            flex: 7,
            child: Consumer<DateNotifier>(
              builder: (context, date, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DateSquare(
                      day: getWeekdayName(date.currentDate, 2),
                      date: Converter.stringToDatetime(date.currentDate).day - 2
                    ),
                    DateSquare(
                        day: getWeekdayName(date.currentDate, 1),
                        date: Converter.stringToDatetime(date.currentDate).day - 1),
                    DateSquare(
                        day: getWeekdayName(date.currentDate, 0),
                        date: Converter.stringToDatetime(date.currentDate).day),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class HabitTile extends StatelessWidget {
  final Habit _habit;
  late List<HabitSquare> habitSquares;

  HabitTile(this._habit, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 15),
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onLongPress: () {
          Navigator.push(context,
            MaterialPageRoute(builder: (context) {
              return HabitInfoScreen(_habit);
            })
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Consumer<ThemeNotifier>(
            builder: (context, model, child) {
              return Container(
                color: model.primaryColor,
                height: squareSize + 20,
                width: double.infinity,
                child: InkWell(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: Container(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            _habit.name,
                            style: TextStyle(
                              color: model.textColor,
                              fontWeight: FontWeight.w500),
                            )
                        )
                      ),
                      Container(
                        width: 1,
                        color: CColors.yellowWithOpacity,
                      ),
                      Expanded(
                        flex: 10,
                        child: Consumer<DateNotifier>(
                          builder: (context, date, child) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                HabitSquare(
                                  id: 2,
                                  habit: _habit,
                                ),
                                HabitSquare(
                                  id: 1,
                                  habit: _habit,
                                ),
                                HabitSquare(
                                  id: 0,
                                  habit: _habit,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class HabitSquare extends StatefulWidget {
  final int id;
  final Habit habit;

  HabitSquare(
      {required this.id,
      required this.habit,
      super.key});

  @override
  State<HabitSquare> createState() => _HabitSquareState();
}

class _HabitSquareState extends State<HabitSquare> {
  late final Color backgroundColor;
  late Color foregroundColor;

  @override
  void initState() {
    super.initState();
    backgroundColor = widget.habit.color.withOpacity(0.2);
    foregroundColor = backgroundColor;
  }

  @override
  Widget build(BuildContext context) {

    String today = Provider.of<DateNotifier>(context, listen: true).currentDate;
    String thisDay = Converter.subtractDaysStringToString(today, widget.id);

    foregroundColor = (widget.habit.wasDone[thisDay] ?? false)
        ? widget.habit.color
        : backgroundColor ;

    if (widget.habit.wasDone[thisDay] == null) {
      widget.habit.wasDone[thisDay] = false;
    }

    return InkWell(
      onTap: () {
        setState(() {
          foregroundColor = widget.habit.color;
          widget.habit.wasDone[thisDay] = true;
          FirestoreService.updateHabit(widget.habit.docID, widget.habit);
        });
      },
      onDoubleTap: () {
        setState(() {
          foregroundColor = backgroundColor;
          widget.habit.wasDone[thisDay] = false;
          FirestoreService.updateHabit(widget.habit.docID, widget.habit);
        });
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: backgroundColor,
          height: squareSize,
          width: squareSize,
          alignment: Alignment.center,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              color: foregroundColor,
              height: squareSize - 4,
              width: squareSize - 4,
              alignment: Alignment.center,
            ),
          ),
        ),
      ),
    );
  }
}

class DateSquare extends StatelessWidget {
  final String day;
  final int date;

  DateSquare({required this.day, required this.date, super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Consumer<ThemeNotifier>(
        builder: (context, model, child) {
          return Container(
            color: model.primaryColor.withOpacity(0.2),
            height: squareSize,
            width: squareSize,
            alignment: Alignment.center,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: model.primaryColor,
                height: squareSize - 4,
                width: squareSize - 4,
                alignment: Alignment.center,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    TextSpan(
                        text: day,
                        style: TextStyle(
                            color: model.textColor.withOpacity(0.5),
                            fontWeight: FontWeight.w700,
                            fontSize: 10)),
                    TextSpan(
                        text: "\n$date",
                        style: TextStyle(
                            color: model.textColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 15))
                  ]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
