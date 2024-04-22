import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/c_colors.dart';
import '../entities/habit.dart';
import '../models.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_nav_bar.dart';

class HabitInfoScreen extends StatelessWidget {
  final Habit _habit;
  final _navigatorKey = GlobalKey<NavigatorState>();

  HabitInfoScreen(this._habit, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Consumer<ThemeNotifier>(
          builder: (context, theme, child) {
            return Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Stack(
                      children: [
                        Image.asset(
                          "lib/images/Homepage.png",
                          fit: BoxFit.cover,
                        ),
                        Container(
                          color: Colors.black.withOpacity(theme.isDarkTheme ? 0.5 : 0),
                        )
                      ]
                  ),
                ),
                Column(
                  children: [
                    const Expanded(child: SizedBox()),
                    Expanded(
                      flex: 6,
                      child: Container(
                        padding: EdgeInsets.all(30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name: ${_habit.name}",
                              style: TextStyle(
                                color: theme.textColor,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                            const SizedBox(height: 10),
                            RichText(text: TextSpan(
                              style: TextStyle(
                                color: theme.textColor,
                                fontWeight: FontWeight.w500
                              ),
                              children: [
                                const TextSpan(
                                  text: "Color: "
                                ),
                                TextSpan(
                                  text: "  ████",
                                  style: TextStyle(
                                    color: _habit.color
                                  )
                                )
                              ]
                            ))
                          ],
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
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back)
                      ),
                      action: IconButton(
                          onPressed: () {

                          },
                          icon: const Icon(Icons.edit_outlined)
                      ),
                      title: 'Habit\'s Information',
                    ),
                    const Expanded(child: SizedBox()),
                    BottomNavBar(
                        _navigatorKey,
                            () {
                          Navigator.pushNamed(context, '/newHabit');
                        },
                        const Icon(
                          Icons.add_rounded,
                          size: 35,
                          color: CColors.purple,
                        )
                    )
                  ],
                ),
              ],
            );
          },
        )
    );
  }
}
