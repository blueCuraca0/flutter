import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../CColors.dart';
import 'ListPoint.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {

  static const double _upperPanelHeight = 150;

  static final List<String> _points = [
    ">  Personalization",
    ">  Downloads",
    ">  Notifications",
    ">  Content Settings",
    ">  Playback",
    ">  Appearance",
    ">  Version Info",
  ];
  static final List<String> _subpoints = [
    "    -  Preferred Language\n    -  Region",
    "    -  Auto Download\n    -  Remove completed ep.\n    -  Remove unfinished ep.",
    "    - Audio Playback\n    - New ep. from subs",
    "",
    "",
    "",
    ""
  ];

  static late List<ListPoint> _pointsAndSubpoints;

  @override
  void initState() {
    super.initState();
    _pointsAndSubpoints = List.generate(
        min(_points.length, _subpoints.length),
        (index) => ListPoint(_points[index], _subpoints[index])
      );
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.7,
      heightFactor: 1,
      child: Container(
        color: CColors.background,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: _upperPanelHeight,
                  color: CColors.bottomNavBar,
                ),
                Container(
                  height: MediaQuery.of(context).size.height - _upperPanelHeight,
                  padding: const EdgeInsets.only(
                    left: 30,
                    right: 30,
                    bottom: 30,
                    top: 40,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Settings",
                        style: TextStyle(
                          fontSize: 26,
                          shadows: [
                            Shadow(
                              blurRadius: 7,
                              offset: Offset(1, 1),
                              color: Colors.grey
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: ListView(
                          children: List.generate(
                              min(_points.length, _subpoints.length),
                              (index) => _pointsAndSubpoints[index]
                          ),
                        )
                      ),
                    ],
                  ),
                )
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 130, left: 15),
              child: Icon(
                Icons.settings,
                color: CColors.item,
                size: 40,
                shadows: [
                  Shadow(
                      blurRadius: 13,
                      offset: Offset(3, 3),
                      color: Colors.black54
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
