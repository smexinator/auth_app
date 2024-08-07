import 'package:flutter/animation.dart';

class EnterAnimation {
  EnterAnimation(
    AnimationController controller,
    TickerProvider vsync, {
    Duration duration = const Duration(seconds: 1),
    Curve curve = Curves.easeInOutBack,
  }) : _controller = controller {
    _circleSize = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(curve: curve, parent: _controller),
    );
  }

  final AnimationController _controller;
  late final Animation<double> _circleSize;

  AnimationController get getController => _controller;
  Animation<double> get getCircleSize => _circleSize;

  void forward() {
    _controller.forward();
  }

  void reverse() {
    _controller.reverse();
  }

  void dispose() {
    _controller.dispose();
  }
}
