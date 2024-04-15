import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../Model.dart';
import '../constants/CColors.dart';
import '../entities/Habit.dart';

const double squareSize = 50;

class HabitList extends StatelessWidget {
  final Size size;
  final List<HabitTile> habitTiles;

  const HabitList(this.habitTiles, this.size, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 3 / 5,
      width: size.width,
      child: ListView(
        children: [
          HabitListHeader(),
          ...habitTiles,
          const DeleteButton(),
          SizedBox(
            height: size.height / 5,
          )
        ],
      ),
    );
  }
}

class DeleteButton extends StatelessWidget {
  const DeleteButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HabitNotifier>(
      builder: (context, model, child) {
        return model.habits.isEmpty
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.all(30),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Consumer<ThemeNotifier>(
                    builder: (context, theme, child) {
                      return Container(
                        color: theme.primaryColor,
                        width: 30,
                        child: IconButton(
                          onPressed: () {
                            Future.delayed(const Duration(seconds: 1)).then((value) {
                              model.deleteAllHabits();
                            });
                          },
                          icon: Icon(
                            Icons.delete_sweep_outlined,
                            size: 30,
                            color: theme.textColor,
                          )),
                      );
                    },
                  ),
                ),
              );
      },
    );
  }
}

class HabitListHeader extends StatelessWidget {
  HabitListHeader({super.key});

  String getWeekdayName(DateTime today) {
    switch (today.weekday) {
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
      padding: const EdgeInsets.only(left: 30, right: 30),
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
                        day: getWeekdayName(
                            date.currentDate.subtract(const Duration(days: 2))),
                        date: date.currentDate.day - 2),
                    DateSquare(
                        day: getWeekdayName(
                            date.currentDate.subtract(const Duration(days: 1))),
                        date: date.currentDate.day - 1),
                    DateSquare(
                        day: getWeekdayName(date.currentDate),
                        date: date.currentDate.day),
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
  late final List<HabitSquare> habitSquares;

  HabitTile(this._habit, {super.key}) {
    habitSquares = [
      HabitSquare(
        id: 0,
        habit: _habit,
        color: CColors.orange,
      ),
      HabitSquare(
        id: 1,
        habit: _habit,
        color: CColors.orange,
      ),
      HabitSquare(
        id: 2,
        habit: _habit,
        color: CColors.orange,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Consumer<ThemeNotifier>(
          builder: (context, model, child) {
            return Container(
              color: model.primaryColor,
              height: squareSize + 20,
              width: double.infinity,
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
                          ))),
                  Container(
                    width: 1,
                    color: CColors.yellowWithOpacity,
                  ),
                  Expanded(
                    flex: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: habitSquares,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class HabitSquare extends StatefulWidget {
  late final int id;
  final Color color;
  final Habit habit;

  HabitSquare(
      {required this.id,
      required this.habit,
      this.color = Colors.white,
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
    backgroundColor = widget.color.withOpacity(0.2);
    foregroundColor =
        (widget.habit.wasDone[widget.id]) ? widget.color : backgroundColor;
  }

  @override
  Widget build(BuildContext context) {
    return widget.habit.wasDone.isEmpty
        ? const SizedBox()
        : InkWell(
            onTap: () {
              setState(() {
                foregroundColor = widget.color;
                widget.habit.wasDone[widget.id] = true;
              });
            },
            onDoubleTap: () {
              setState(() {
                foregroundColor = backgroundColor;
                widget.habit.wasDone[widget.id] = false;
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
