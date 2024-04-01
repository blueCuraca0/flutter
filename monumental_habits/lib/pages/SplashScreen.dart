import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isSplashScreenOpen = true;

  double _opacity = 1;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !_isSplashScreenOpen,
      child: InkWell(
        onTap: () {
          setState(() {
            _opacity = 0;
            _isSplashScreenOpen = false;
          });
        },
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: AnimatedOpacity(
            opacity: _opacity,
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeInOut,
            child: Image.asset(
              "lib/images/Splash Screen.png",
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
