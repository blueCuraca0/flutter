import 'package:flutter/material.dart';
import 'package:monumental_habits/widgets/app_bar.dart';
import 'package:provider/provider.dart';

import '../models.dart';
import '../constants/c_colors.dart';
import '../entities/habit.dart';
import '../services/firestore_service.dart';
import '../widgets/bottom_nav_bar.dart';

class NewHabitScreen extends StatefulWidget {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  NewHabitScreen({super.key});

  @override
  State<NewHabitScreen> createState() => _NewHabitScreenState();
}

class _NewHabitScreenState extends State<NewHabitScreen> {
  final _textController = TextEditingController();
  Color chosenColor = CColors.orange;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Consumer<ThemeNotifier>(
                builder: (context, theme, child) {
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        "lib/images/Homepage.png",
                        fit: BoxFit.cover,
                      ),
                      Container(
                        color:
                            Colors.black.withOpacity(theme.isDarkTheme ? 0.5 : 0),
                      )
                    ]
                  );
                },
              ),
            ),
            Consumer<ThemeNotifier>(
              builder: (context, theme, child) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: TextField(
                        controller: _textController,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: theme.secondaryColor, width: 0.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  BorderSide(color: theme.secondaryColor),
                            ),
                            labelText: 'Habit Name',
                            labelStyle: TextStyle(color: theme.textColor)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 60,
                          width: double.infinity,
                          color: theme.primaryColor,
                          padding: const EdgeInsets.all(15),
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              Text(
                                "Color: ",
                                style: TextStyle(
                                    color: theme.textColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15),
                              ),
                              const Expanded(child: SizedBox()),
                              InkWell(
                                onTap: () async {
                                  Color color = await Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return ColorPalette(
                                      primary: theme.primaryColor,
                                      secondary: theme.secondaryColor,
                                    );
                                  }));
                                  setState(() {
                                    chosenColor = color;
                                  });
                                },
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            top: 5,
                                            bottom: 5,
                                            right: 15,
                                            left: 15),
                                        width: 100,
                                        color: chosenColor,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Icon(
                                      Icons.arrow_drop_down_circle_outlined,
                                      color: theme.secondaryColor,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
            Column(
              children: [
                MyAppBar(
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back)),
                  title: 'New Habit',
                ),
                const Expanded(child: SizedBox()),
                BottomNavBar(
                  widget._navigatorKey,
                  () {
                    Habit habit = Habit(name: _textController.text, color: chosenColor);
                    // Provider.of<HabitNotifier>(context, listen: false).addHabitAndTile(habit);
                    FirestoreService.addHabit(habit);
                    Navigator.pop(context);
                    _textController.text = "";
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
        ));
  }
}

class ColorPalette extends StatelessWidget {
  final Color primary;
  final Color secondary;
  final List<Color> colors = const [
    CColors.orange,
    CColors.blue,
    CColors.red,
    CColors.purple
  ];

  const ColorPalette(
      {required this.primary, required this.secondary, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondary,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Stack(children: [
              Image.asset(
                "lib/images/Homepage.png",
                fit: BoxFit.cover,
              ),
              Container(
                color: Colors.black.withOpacity(0.5),
              )
            ]),
          ),
          Align(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: 300,
                height: 300,
                color: primary,
                padding: const EdgeInsets.all(20),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ColorExample(colors[0]),
                        const SizedBox(
                          width: 20,
                        ),
                        ColorExample(colors[1]),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ColorExample(colors[2]),
                        const SizedBox(
                          width: 20,
                        ),
                        ColorExample(colors[3]),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ColorExample extends StatelessWidget {
  final Color color;

  const ColorExample(this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context, color);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          color: color.withOpacity(0.2),
          height: 100,
          width: 100,
          padding: const EdgeInsets.all(7),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}
