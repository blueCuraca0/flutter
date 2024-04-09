import 'package:flutter/material.dart';
import 'package:monumental_habits/widgets/AppBar.dart';
import 'package:provider/provider.dart';

import '../Model.dart';
import '../constants/CColors.dart';
import '../entities/Habit.dart';
import '../widgets/BottomNavBar.dart';

class NewHabitScreen extends StatelessWidget {
  final _controller = TextEditingController();

  NewHabitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Consumer<Model>(
        builder: (context, model, child) {
          return Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Image.asset(
                  "lib/images/Homepage.png",
                  opacity: AlwaysStoppedAnimation(model.isDarkTheme ? 0.5 : 1),
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
                  ),
                ],
              ),
              Column(
                children: [
                  MyAppBar(
                    leading: IconButton(
                        onPressed: () { model.setCurrentPage(1); },
                        icon: const Icon(Icons.arrow_back)
                    ),
                    title: 'New Habit',
                  ),
                  const Expanded(child: SizedBox()),
                  BottomNavBar(
                          () {
                        model
                          ..addHabitAndTile(Habit(name: _controller.text, wasDone: []))
                          ..setCurrentPage(1);
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
          );
        }
      )
    );
  }

}

