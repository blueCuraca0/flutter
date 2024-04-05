import 'package:flutter/material.dart';
import 'package:monumental_habits/widgets/AppBar.dart';
import 'package:provider/provider.dart';

import '../Model.dart';
import '../constants/CColors.dart';
import '../entities/Habit.dart';
import '../widgets/BottomNavBar.dart';

class NewHabit extends StatelessWidget {
  final Function _setCurrentPage;
  final _controller = TextEditingController();

  NewHabit(this._setCurrentPage, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              "lib/images/Homepage.png",
              // "lib/assets/Homepage.png",
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              const Expanded(child: SizedBox()),
              Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Habit Name',
                      ),
                    ),
                  ),
                  // child: HabitList(habitTiles, size)
              ),
            ],
          ),
          Column(
            children: [
              MyAppBar(
                leading: IconButton(
                    onPressed: () {
                      _setCurrentPage(1);
                    },
                    icon: const Icon(Icons.arrow_back)
                ),
                title: 'New Habit',
              ),
              const Expanded(child: SizedBox()),
              BottomNavBar(
                () {
                  Provider.of<Model>(context, listen: false).addHabitAndTile(Habit(name: _controller.text, wasDone: []));
                  _setCurrentPage(1);
                  _controller.text = "";
                },
                const Icon(
                  Icons.done_rounded,
                  size: 35,
                  color: CColors.purple,
                )
              )
            ],
          ),
        ],
      ),
    );
  }
}
