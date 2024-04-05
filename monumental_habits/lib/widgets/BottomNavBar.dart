import 'package:flutter/material.dart';

import '../../constants/CColors.dart';

class BottomNavBar extends StatelessWidget {

  final Function _onFABTap;
  final Icon _icon;

  const BottomNavBar(this._onFABTap, this._icon, {super.key});

  static const double _bottomNavBarHeightPanel = 80;
  static const double _floatingActionButtonHeight = 60;
  static const double _bottomNavBarFullHeight =
      _bottomNavBarHeightPanel + _floatingActionButtonHeight;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return SizedBox(
        height: _bottomNavBarHeightPanel + _floatingActionButtonHeight * 2 / 3,
        child: Stack(
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              child: CustomPaint(
                size: const Size(double.infinity, _bottomNavBarHeightPanel),
                painter: BottomNavBarCustomPainter(width, _bottomNavBarHeightPanel),
              ),
            ),
            Container(
                height: _bottomNavBarFullHeight,
                alignment: Alignment.topCenter,
                child: MyFloatingActionButton(
                  _floatingActionButtonHeight,
                  _onFABTap,
                  _icon,
                )
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: _bottomNavBarHeightPanel,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(onPressed: () {}, icon: const Icon(Icons.home)),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.article)),
                    const SizedBox(width: 40),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.group)),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}

class BottomNavBarCustomPainter extends CustomPainter {
  final double _width;
  final double _height;

  const BottomNavBarCustomPainter(this._width, this._height);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
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