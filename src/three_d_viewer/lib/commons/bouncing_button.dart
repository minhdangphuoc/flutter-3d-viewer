import 'package:flutter/material.dart';

import '../theme.dart';

class BouncingButton extends StatefulWidget {
  @override
  _BouncingButtonState createState() => _BouncingButtonState();
}

class _BouncingButtonState extends State<BouncingButton>
    with SingleTickerProviderStateMixin {
  late double _scale;
  late AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 500,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GestureDetector(
          onTapDown: _tapDown,
          onTapUp: _tapUp,
          child: Transform.scale(
            scale: _scale,
            child: _animatedButton(),
          ),
        ),
      ),
    );
  }

  Widget _animatedButton() {
    return Container(
      height: 70,
      width: 320,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Color(0x80000000),
            blurRadius: 12.0,
            offset: Offset(0.0, 5.0),
          ),
        ],
        color: selectedColor,
      ),
      child: Center(
        child: MediaQuery.of(context).size.width > 540
            ? Text(
                'Add new file',
                style: TextStyle(
                    fontFamily: 'WorkSans',
                    fontWeight: FontWeight.w500,
                    fontSize: 22,
                    color: Colors.black),
              )
            : Icon(
                Icons.add,
                size: 32.0,
              ),
      ),
    );
  }

  void _tapDown(TapDownDetails details) {
    _controller.forward();
    print('upload');
  }

  void _tapUp(TapUpDetails details) {
    _controller.reverse();
  }
}
