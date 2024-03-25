import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../CColors.dart';


class PopupAccountWindow extends StatefulWidget {
  const PopupAccountWindow({super.key});

  @override
  State<PopupAccountWindow> createState() => _PopupAccountWindowState();
}

class _PopupAccountWindowState extends State<PopupAccountWindow> {

  double _screenHeight = 0;
  double _screenWidth = 0;
  double _windowHeight = 0;
  double _windowWidth = 0;
  // double _appAndBottomBarHeight = 0;

  @override
  Widget build(BuildContext context) {
    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;
    _windowHeight = _screenHeight * 0.35;
    _windowWidth = _screenWidth * 0.8;

/*    _appAndBottomBarHeight = MediaQuery.of(context).padding.top + MediaQuery.of(context).padding.bottom;
    _windowHeight = (MediaQuery.of(context).size.height - _appAndBottomBarHeight) * 0.5;
    _windowWidth = (MediaQuery.of(context).size.width - _appAndBottomBarHeight) * 0.8;*/

    return Container(
      width: _screenWidth,
      height: _screenHeight,
      color: Colors.black54,
      child: Center(
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          child: Container(
            width: _windowWidth,
            height: _windowHeight,
            color: CColors.background,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  child: Column(
                    children: [
                      Container(
                        color: CColors.selected_background,
                        width: _windowWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(
                                top: 15,
                                left: 5,
                                right: 5,
                                bottom: 5
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.account_circle),
                                  Text("annyonghoseyopabo@gmail.com"),
                                ],
                              ),
                            ),
                            Container(
                              color: CColors.item,
                              height: 1,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                  top: 15,
                                  left: 18,
                                  right: 18,
                              ),
                              child: Text("Manage your Google Account"),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                  top: 15,
                                  left: 18,
                                  right: 18,
                                  bottom: 15
                              ),
                              child: Text("Content policies"),
                            )
                          ],
                        )
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                    bottom: 0,
                    left: 15,
                    right: 10
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.settings_outlined),
                      Text("  Podcast settings")
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                    bottom: 0,
                    left: 15,
                    right: 10
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.help_outline),
                      Text("  Help")
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                    bottom: 0,
                    left: 15,
                    right: 10
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.feedback_outlined),
                      Text("  Feedback")
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
