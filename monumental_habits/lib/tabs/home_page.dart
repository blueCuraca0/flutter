import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:monumental_habits/widgets/app_bar.dart';
import 'package:provider/provider.dart';

import '../models.dart';
import '../constants/c_colors.dart';
import '../constants/c_strings.dart';
import '../services/firestore_service.dart';
import '../widgets/habit_list.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.transparent,
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
                        fit: BoxFit.fitWidth,
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
              const SizedBox(height: 230),
              Expanded(
                child: HabitList(size),
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
          width: double.infinity,
          height: 130,
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        CStrings.inspiringQuotes[
                        Random().nextInt(CStrings.inspiringQuotes.length)],
                        style: const TextStyle(
                          color: CColors.purple,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        CStrings.quoteAuthor,
                        style: TextStyle(
                            color: CColors.purple.withOpacity(0.5),
                            fontWeight: FontWeight.w500,
                            fontSize: 12
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Image.asset("lib/images/Quote girl.png",)
            ],
          ),
        ),
      ),
    );
  }
}
