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
          SizedBox(height: size.height / 5,)
        ],
      ),
    );
  }
}

class HabitListHeader extends StatelessWidget {
  HabitListHeader({super.key});

  late DateTime today;

  String getWeekdayName (DateTime today) {
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
    today = Provider.of<Model>(context).currentDate;
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Row(
        children: [
          const Expanded(
            flex: 4,
            child: Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "HABITS",
                style: TextStyle(
                    color: CColors.purple,
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DateSquare(
                  day: getWeekdayName(today.subtract(const Duration(days: 2))),
                  date: today.day - 2
                ),
                DateSquare(
                  day: getWeekdayName(today.subtract(const Duration(days: 1))),
                  date: today.day - 1
                ),
                DateSquare(day: getWeekdayName(today), date: today.day),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HabitTile extends StatelessWidget {
  final Habit _habit;
  // int daysCounter = 0;
  late List<HabitSquare> habitSquares;

  HabitTile(this._habit, {super.key});

  @override
  Widget build(BuildContext context) {
    habitSquares = [
      HabitSquare(id: 0, habit: _habit, color: CColors.orange,),
      HabitSquare(id: 1, habit: _habit, color: CColors.orange,),
      HabitSquare(id: 2, habit: _habit, color: CColors.orange,),
    ];
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          color: Colors.white,
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
                    style: const TextStyle(
                      color: CColors.purple,
                      fontWeight: FontWeight.w500
                    ),
                  )
                )
              ),
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
        ),
      ),
    );
  }
}

class HabitSquare extends StatefulWidget {
  late final int id;
  final Color color;
  final Habit habit;

  HabitSquare({
    required this.id,
    required this.habit,
    this.color = Colors.white,
    super.key
  });

  @override
  State<HabitSquare> createState() => _HabitSquareState();
}

class _HabitSquareState extends State<HabitSquare> {
  late final Color backgroundColor;
  late Color foregroundColor;
  bool isNewWasDoneElementCreated = false;

  @override
  void initState() {
    super.initState();

    if(!isNewWasDoneElementCreated) {
      widget.habit.newDate();
      setState(() {
        isNewWasDoneElementCreated = true;
      });
    }

    backgroundColor = widget.color.withOpacity(0.2);
    foregroundColor = (widget.habit.wasDone[widget.id]) ? widget.color : backgroundColor;
  }

  @override
  Widget build(BuildContext context) {
    return widget.habit.wasDone.isEmpty ? const SizedBox() : InkWell(
      onTap: () {
        setState(() {
          foregroundColor = widget.color;
          widget.habit.wasDone[widget.id] = true;
          // print("> ${widget.id} IS ${widget.habit.wasDone[widget.id]}");
        });
      },
      onDoubleTap: () {
        setState(() {
          foregroundColor = backgroundColor;
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
  final Color color;
  final String day;
  final int date;

  DateSquare({
    this.color = Colors.white,
    required this.day,
    required this.date,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        color: color.withOpacity(0.2),
        height: squareSize,
        width: squareSize,
        alignment: Alignment.center,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            color: color,
            height: squareSize - 4,
            width: squareSize - 4,
            alignment: Alignment.center,
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  children: [
                    TextSpan(
                        text: day,
                        style: TextStyle(
                            color: CColors.purple.withOpacity(0.5),
                            fontWeight: FontWeight.w700,
                            fontSize: 10
                        )
                    ),
                    TextSpan(
                        text: "\n$date",
                        style: const TextStyle(
                            color: CColors.purple,
                            fontWeight: FontWeight.w700,
                            fontSize: 15
                        )
                    )
                  ]
              ),
            ),
          ),
        ),
      ),
    );
  }
}
