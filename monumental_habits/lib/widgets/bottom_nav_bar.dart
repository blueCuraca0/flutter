import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/c_colors.dart';
import '../constants/c_routes.dart';
import '../models.dart';

class BottomNavBar extends StatelessWidget {

  final GlobalKey<NavigatorState> _navigator;
  final Function _onFABTap;
  final Icon _iconFAB;

  BottomNavBar(this._navigator ,this._onFABTap, this._iconFAB, {super.key});

  static const double _bottomNavBarHeightPanel = 80;
  static const double _floatingActionButtonHeight = 60;
  static const double _bottomNavBarFullHeight =
      _bottomNavBarHeightPanel + _floatingActionButtonHeight;

  // late PageController _pageController;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    // _pageController1 = Provider.of<TabNotifier>(context, listen: false).pageController;

    return SizedBox(
        height: _bottomNavBarHeightPanel + _floatingActionButtonHeight * 2 / 3,
        child: Consumer<ThemeNotifier>(
          builder: (context, theme, child) {
            return Stack(
              children: [
                Container(
                  alignment: Alignment.bottomCenter,
                  child: CustomPaint(
                    // TODO чому без цього поля не працює?
                    // а тепер працює...
                    // key: ValueKey(theme.isDarkTheme),
                    size: const Size(double.infinity, _bottomNavBarHeightPanel),
                    painter: BottomNavBarCustomPainter(
                        width,
                        _bottomNavBarHeightPanel,
                        theme.primaryColor
                    ),
                  ),
                ),
                Container(
                    height: _bottomNavBarFullHeight,
                    alignment: Alignment.topCenter,
                    child: MyFloatingActionButton(
                      _floatingActionButtonHeight,
                      _onFABTap,
                      _iconFAB,
                    )
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: _bottomNavBarHeightPanel,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {
                              _navigator.currentState?.pushReplacementNamed(CRoutes.routeHomePage);
                            },
                            icon: Icon(Icons.home, color: theme.secondaryColor.withOpacity(0.75))
                        ),
                        IconButton(
                            onPressed: () {
                              _navigator.currentState?.pushReplacementNamed(CRoutes.routeCourses);
                            },
                            icon: Icon(Icons.article, color: theme.secondaryColor.withOpacity(0.75))
                        ),
                        const SizedBox(width: 40),
                        IconButton(
                            onPressed: () {
                              _navigator.currentState?.pushReplacementNamed(CRoutes.routeCommunity);
                            },
                            icon: Icon(Icons.group, color: theme.secondaryColor.withOpacity(0.75))
                        ),
                        IconButton(
                            onPressed: () {
                              _navigator.currentState?.pushReplacementNamed(CRoutes.routeSettings);
                            },
                            icon: Icon(Icons.settings, color: theme.secondaryColor.withOpacity(0.75))
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          }
        )
    );
  }
}

class BottomNavBarCustomPainter extends CustomPainter {
  final double _width;
  final double _height;
  final Color _color;

  const BottomNavBarCustomPainter(this._width, this._height, this._color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = _color
      ..style = PaintingStyle.fill;

    Path path = Path()
      ..moveTo(0, _height / 5)
    // left part
      ..quadraticBezierTo(_width * 0.2, 0, _width * 0.40, 0)
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
  final Function _onFABTap;
  final Icon _icon;

  const MyFloatingActionButton(
      this._floatingActionButtonHeight,
      this._onFABTap,
      this._icon,
      {super.key}
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _onFABTap();
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
                child: _icon
            ),
          ),
        ),
      ),
    );
  }
}