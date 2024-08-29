import 'package:flutter/material.dart';
import 'dart:math' as math;

class ShowLoader extends StatefulWidget {
  const ShowLoader({Key? key}) : super(key: key);

  @override
  _ShowLoaderState createState() => _ShowLoaderState();
}

class _ShowLoaderState extends State<ShowLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 3000))
        ..repeat();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, child) {
          return Transform.scale(
            scale: _controller.value*1.15,
            child: child,
          );
        },
        child: Image.asset('assets/gas.png', ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
