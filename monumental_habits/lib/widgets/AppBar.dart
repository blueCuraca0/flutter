import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/CColors.dart';

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
      child: Row(
        children: [
          ClipOval(
            child: Container(
              color: CColors.purple.withOpacity(0.15),
              child: leading,
            ),
          ),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: CColors.purple),
            ),
          ),
          ClipOval(
            child: Container(
              color: CColors.purple.withOpacity(0.15),
              child: action ?? const SizedBox(width: 45),
            ),
          )
        ],
      ),
    );
  }
}