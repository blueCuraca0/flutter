import 'package:flutter/material.dart';
import 'package:monumental_habits/widgets/AppBar.dart';
import 'package:provider/provider.dart';

import '../Model.dart';
import '../constants/CColors.dart';
import '../entities/Habit.dart';
import '../widgets/BottomNavBar.dart';

class NewHabitScreen extends StatefulWidget {
  const NewHabitScreen({super.key});

  @override
  State<NewHabitScreen> createState() => _NewHabitScreenState();
}

class _NewHabitScreenState extends State<NewHabitScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Consumer<ThemeNotifier>(
              builder: (context, theme, child) {
                return Stack(
                    children: [
                      Image.asset(
                        "lib/images/Homepage.png",
                        fit: BoxFit.cover,
                      ),
                      Container(
                        color: Colors.black.withOpacity(theme.isDarkTheme ? 0.5 : 0),
                      )
                    ]
                );
              },
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
                  onPressed: () {
                    Provider.of<ScreenNotifier>(context, listen: false).setCurrentPage(1);
                  },
                  icon: const Icon(Icons.arrow_back)
                ),
                title: 'New Habit',
              ),
              const Expanded(child: SizedBox()),
              BottomNavBar(
                () {
                  Provider.of<HabitNotifier>(context, listen: false).addHabitAndTile(Habit(name: _controller.text));
                  Provider.of<ScreenNotifier>(context, listen: false).setCurrentPage(1);
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
      )
    );
  }
}

