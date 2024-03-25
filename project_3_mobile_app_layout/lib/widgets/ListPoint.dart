import 'package:flutter/material.dart';

class ListPoint extends StatefulWidget {
  final String _point;
  final String _subpoint;

  const ListPoint(this._point, this._subpoint, {super.key});

  @override
  State<ListPoint> createState() => _ListPointState();
}

class _ListPointState extends State<ListPoint> {
  var _isOpened = false;

  _ListPointState();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.orange,
      onTap: () {
        setState(() {
          _isOpened = !_isOpened;
        });
      },
      child: Container(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              FractionallySizedBox(
                widthFactor: 1,
                child: Text(
                  widget._point,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              FractionallySizedBox(
                widthFactor: 1,
                child: _isOpened ?
                Text(widget._subpoint, style: const TextStyle(fontSize: 14),)
                    : const SizedBox(),
              )
            ],
          ),
        ),
      ),
    );
  }
}