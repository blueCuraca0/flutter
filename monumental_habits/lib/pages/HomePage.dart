import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

import '../constants/CColors.dart';
import '../constants/CStrings.dart';
import '../widgets/HabitList.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<HabitTile> habitTiles = [];

  void _addHabit() {
    setState(() {
      habitTiles.add(const HabitTile());
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

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
                flex: 2,
                child: HabitList(habitTiles, size)
              ),
            ],
          ),
          Column(
            children: [
              const MyAppBar(),
              const InspiringQuote(),
              const Expanded(child: SizedBox()),
              BottomNavBar(_addHabit)
            ],
          ),
        ],
      ),
    );
  }
}

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ClipOval(
            child: Container(
              color: CColors.purple.withOpacity(0.15),
              child: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
            ),
          ),
          const Text(
            "Homepage",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: CColors.purple),
          ),
          ClipOval(
            child: Container(
              color: CColors.purple.withOpacity(0.15),
              child: IconButton(
                  onPressed: () {}, icon: const Icon(Icons.account_circle)),
            ),
          )
        ],
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  final Function _addHabit;

  const BottomNavBar(this._addHabit, {super.key});

  static const double _bottomNavBarHeightPanel = 80;
  static const double _floatingActionButtonHeight = 60;
  static const double _bottomNavBarFullHeight =
      _bottomNavBarHeightPanel + _floatingActionButtonHeight;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return SizedBox(
        height: _bottomNavBarHeightPanel + _floatingActionButtonHeight * 2 / 3,
        child: Stack(
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              child: CustomPaint(
                size: const Size(double.infinity, _bottomNavBarHeightPanel),
                painter: BottomNavBarCustomPainter(width, _bottomNavBarHeightPanel),
              ),
            ),
            Container(
                height: _bottomNavBarFullHeight,
                alignment: Alignment.topCenter,
                child: MyFloatingActionButton(
                  _floatingActionButtonHeight,
                  _addHabit
                )
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: _bottomNavBarHeightPanel,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(onPressed: () {}, icon: const Icon(Icons.home)),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.article)),
                    const SizedBox(width: 40),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.group)),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}

class BottomNavBarCustomPainter extends CustomPainter {
  final double _width;
  final double _height;

  const BottomNavBarCustomPainter(this._width, this._height);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path()
      ..moveTo(0, _height / 5)

      // left part
      ..quadraticBezierTo(_width * 0.2, 0, _width * 0.40, 0) // LINE TO??

      // center
      ..cubicTo(_width * 0.45, _height * 0.45, _width * 0.55, _height * 0.45,
          _width * 0.6, 0)

      // right part
      ..quadraticBezierTo(_width * 0.6, 0, _width * 0.65, 0)
      ..quadraticBezierTo(_width * 0.8, 0, _width, _height / 5)

      // bottom part
      ..lineTo(_width, _height)
      ..lineTo(0, _height);

    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class MyFloatingActionButton extends StatelessWidget {
  final double _floatingActionButtonHeight;
  final Function _addHabit;

  const MyFloatingActionButton(this._floatingActionButtonHeight, this._addHabit, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(" > IM PRESSED!");
        _addHabit();
      },
      child: ClipOval(
        child: Container(
          height: _floatingActionButtonHeight,
          width: _floatingActionButtonHeight,
          padding: const EdgeInsets.all(5),
          color: CColors.orange.withOpacity(0.3),
          child: ClipOval(
            child: Container(
                color: CColors.orange,
                child: const Icon(
                  Icons.add_rounded,
                  size: 35,
                  color: CColors.purple,
                )),
          ),
        ),
      ),
    );
  }
}

class InspiringQuote extends StatelessWidget {
  const InspiringQuote({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          color: Colors.white,
          height: 130,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    bottom: 20,
                    left: 15,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        CStrings.inspiringQuotes[
                            Random().nextInt(CStrings.inspiringQuotes.length)],
                        style: const TextStyle(
                          color: CColors.purple,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        CStrings.quoteAuthor,
                        style: TextStyle(
                            color: CColors.purple.withOpacity(0.5),
                            fontWeight: FontWeight.w500,
                            fontSize: 12),
                      )
                    ],
                  ),
                ),
              ),
              Image.asset("lib/images/Quote girl.png")
            ],
          ),
        ),
      ),
    );
  }
}
