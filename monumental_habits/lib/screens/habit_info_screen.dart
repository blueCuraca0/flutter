import 'package:flutter/material.dart';
import 'package:monumental_habits/services/firestore_service.dart';
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
                    fit: StackFit.expand,
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
                        padding: const EdgeInsets.all(30),
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
                            AnimatedColorBox(theme.textColor, _habit.color, MediaQuery.of(context).size.width - (30 * 2)),
                            const SizedBox(height: 50),
                            ProgressBar(_habit.wasDone, _habit.color, MediaQuery.of(context).size.width - (30 * 2)),
                            CompletionHistory(_habit.wasDone),
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

class AnimatedColorBox extends StatefulWidget {
  final Color _textColor;
  final Color _habitColor;
  final double _availableWidth; // width - padding


  const AnimatedColorBox(this._textColor, this._habitColor, this._availableWidth, {super.key});

  @override
  State<AnimatedColorBox> createState() => _AnimatedColorBoxState();
}

class _AnimatedColorBoxState extends State<AnimatedColorBox> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _curve;
  late final Animation _colorAnimation;
  late final Animation _positionAnimation;


  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );

    _curve = CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutCubic
    );

    _colorAnimation = ColorTween(
        begin: widget._habitColor,
        end: widget._habitColor.withOpacity(0)
    ).animate(_curve);

    _positionAnimation = Tween<Offset>(
        begin: const Offset(0, 0),
        end: Offset(widget._availableWidth - 150, 0)
    ).animate(_curve);

    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
      if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return Row(
          children: [
            Text(
              "Color:",
              style: TextStyle(
                  color: widget._textColor,
                  fontWeight: FontWeight.w500
              ),
            ),
            const SizedBox(width: 20,),
            Transform.translate(
              offset: _positionAnimation.value,
              child: Container(
                color: _colorAnimation.value,
                height: 25,
                width: 70,
              ),
            )
          ],
        );

        //   RichText(text: TextSpan(
        //     style: TextStyle(
        //         color: widget._textColor,
        //         fontWeight: FontWeight.w500
        //     ),
        //     children: [
        //       const TextSpan(
        //           text: "Color: "
        //       ),
        //       TextSpan(
        //           text: "  ████",
        //           style: TextStyle(
        //               color: _colorAnimation.value
        //           )
        //       )
        //     ]
        // ));
      },
    );
  }
}


class ProgressBar extends StatefulWidget {
  final Map<String, bool> _wasDone;
  final Color _color;
  final double _availableWidth; // width - padding

  const ProgressBar(this._wasDone, this._color, this._availableWidth, {super.key});

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _curve;
  late final Animation _sizeAnimation;

  double _width = 0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 2300) ,
      vsync: this
    );

    _curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceOut
    );

    // calculating width of the filled bar's part
    int completed = 0;
    for (var entry in widget._wasDone.entries) {
      if (entry.value) completed++;
    }
    _width = widget._availableWidth / widget._wasDone.length * completed;

    _sizeAnimation = Tween<double>(begin: 0, end: _width).animate(_curve);

    Future.delayed(const Duration(milliseconds: 500)).then((value) => _controller.forward());
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        color: Colors.white,
        height: 40,
        width: double.infinity,
        // padding: const EdgeInsets.all(5),
        child: Align(
          alignment: Alignment.centerLeft,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              return Container(
                color: widget._color.withOpacity(0.7),
                width: _sizeAnimation.value,
              );
            },
          )
        ),
      ),
    );
  }
}

class CompletionHistory extends StatelessWidget {
  final Map<String, bool> _wasDone;

  const CompletionHistory(this._wasDone, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: ListView.builder(
        itemCount: _wasDone.length,
        itemBuilder: (context, index) {
          final entry = _wasDone.entries.elementAt(index);

          return Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              children: [
                entry.value
                  ? const Icon(Icons.done_outline, color: Colors.green,)
                  : const Icon(Icons.cancel_outlined, color: Colors.red,),
                const SizedBox(width: 50,),
                Consumer<ThemeNotifier>(
                  builder: (BuildContext context, ThemeNotifier theme, Widget? child) {
                    return Text(
                      entry.key,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: theme.textColor
                      ),
                    );
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
