import 'package:flutter/material.dart';

import '../constants/CColors.dart';

const double squareSize = 50;

class HabitList extends StatelessWidget {
  final Size size;
  final List<HabitTile> habitTiles;

  const HabitList(this.habitTiles, this.size, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          SizedBox(
            height: size.height * 2 / 3,
            width: size.width,
            child: ListView(
              children: [
                HabitListHeader(),
                ...habitTiles,
                SizedBox(height: size.height / 4,)
              ],
            ),
          )
        ],
      ),
    );
  }
}

class HabitListHeader extends StatelessWidget {
  HabitListHeader({super.key});

  int today = 31;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Row(
        children: [
          const SizedBox(width: 20),
          const Text(
            "HABITS",
            style: TextStyle(
                color: CColors.purple,
                fontWeight: FontWeight.w500,
                fontSize: 15),
          ),
          const Expanded(child: SizedBox()),
          DateSquare(day: "THU", date: today - 3),
          DateSquare(day: "FRI", date: today - 2),
          DateSquare(day: "SAT", date: today - 1),
          DateSquare(day: "SUN", date: today),
        ],
      ),
    );
  }
}

class HabitTile extends StatelessWidget {
  const HabitTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          color: Colors.white,
          height: squareSize + 20,
          width: double.infinity,
        ),
      ),
    );
  }
}

class RoundedSquare extends StatelessWidget {
  final Color color;
  final Widget? child;

  const RoundedSquare({this.child, this.color = Colors.white, super.key});

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
            child: child ?? const SizedBox(),
          ),
        ),
      ),
    );
  }
}

class HabitSquare extends StatelessWidget {
  final Color color;

  const HabitSquare({this.color = Colors.white, super.key});

  @override
  Widget build(BuildContext context) {
    return RoundedSquare(
      color: color,
      // TODO в майбутньому тут буде фул виконано чи на половину
      // child: child ?? const SizedBox()
    );
  }
}

class DateSquare extends StatelessWidget {
  final String day;
  final int date;

  const DateSquare({required this.day, required this.date, super.key});

  @override
  Widget build(BuildContext context) {
    return RoundedSquare(
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
    );
  }
}
