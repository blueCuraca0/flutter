import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models.dart';
import '../constants/c_colors.dart';

class MyAppBar extends StatelessWidget {
  final IconButton leading;
  final Widget? action;
  final String title;

  const MyAppBar({
    required this.leading,
    required this.title,
    this.action,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.only(
        left: 30,
        right: 30
      ),
      child: Consumer<ThemeNotifier>(
        builder: (context, model, child) {
          return Row(
            children: [
              ClipOval(
                child: Container(
                  color: model.textColor.withOpacity(0.15),
                  child: leading,
                ),
              ),
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: model.textColor
                  ),
                ),
              ),
              ClipOval(
                child: Container(
                  color: model.textColor.withOpacity(0.15),
                  child: action ?? const SizedBox(width: 45),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}