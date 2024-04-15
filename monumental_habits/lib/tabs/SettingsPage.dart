import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../Model.dart';
import '../constants/CColors.dart';
import '../widgets/AppBar.dart';
import '../widgets/BottomNavBar.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Column(
            children: [
              const Expanded(child: SizedBox()),
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Consumer<ThemeNotifier>(
                        builder: (context, model, child) {
                          return Container(
                            color: model.primaryColor,
                            height: 60,
                            width: double.infinity,
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Text("Theme", style: TextStyle(
                                  color: model.textColor,
                                  fontSize: 18,
                                )),
                                const Expanded(child: SizedBox()),
                                Switch(
                                  value: model.isDarkTheme,
                                  onChanged: (flag) {
                                    setState(() {
                                      model.setIsDarkTheme(flag);
                                    });
                                  }
                                )
                              ],
                            ),
                          );
                        }
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              MyAppBar(
                leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
                title: 'Settings',
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
        ],
      ),
    );
  }
}