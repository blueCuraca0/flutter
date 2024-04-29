import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
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
      ],
    );
  }
}