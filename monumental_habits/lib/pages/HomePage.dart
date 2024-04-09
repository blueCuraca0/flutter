import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:monumental_habits/widgets/AppBar.dart';
import 'package:provider/provider.dart';

import '../Model.dart';
import '../constants/CColors.dart';
import '../constants/CStrings.dart';
import '../entities/Habit.dart';
import '../widgets/BottomNavBar.dart';
import '../widgets/HabitList.dart';

class HomePage extends StatelessWidget {
  final Function _setCurrentPage;

  HomePage(this._setCurrentPage, {super.key});

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
              SizedBox(height: size.height / 4,),
              Expanded(
                child: Consumer<Model>(
                  builder: (context, model, child) {
                    return HabitList(model.habitTiles, size);
                  },
                ),
              )
            ],
          ),
          Column(
            children: [
              MyAppBar(
                leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
                title: 'Homepage',
              ),
              const InspiringQuote(),
              const Expanded(child: SizedBox()),
              BottomNavBar(
                () => _setCurrentPage(2),
                const Icon(
                  Icons.add_rounded,
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
