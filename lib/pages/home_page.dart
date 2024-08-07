import 'package:flutter/material.dart';
import 'package:auth_app/constants.dart';
import 'package:auth_app/utilities/animations/login_page_animation.dart'; // Ensure this import is correct
import 'package:auth_app/utilities/page_routes/slide_page_route.dart';
import 'package:auth_app/pages/login_page.dart';

class AnimatedHomePage extends StatefulWidget {
  @override
  _AnimatedHomePageState createState() => _AnimatedHomePageState();
}

class _AnimatedHomePageState extends State<AnimatedHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this, // Correctly using vsync
      duration: Duration(seconds: 1),
      reverseDuration: Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HomePage(_controller, this); // Pass both required arguments
  }
}

class HomePage extends StatelessWidget {
  final AnimationController _controller;
  final TickerProvider _vsync;
  late final EnterAnimation _animation;
  late final double _deviceHeight;
  late final double _deviceWidth;

  HomePage(this._controller, this._vsync) {
    _animation =
        EnterAnimation(_controller, _vsync); // Pass both required arguments
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Align(
        alignment: Alignment.center,
        child: Container(
          width: _deviceWidth,
          height: _deviceHeight * 0.60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _avatarWidget(),
              SizedBox(height: _deviceHeight * 0.03),
              _nameWidget(),
              SizedBox(height: _deviceHeight * 0.10),
              _logoutButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _avatarWidget() {
    double _circleD = _deviceHeight * 0.25;
    return AnimatedBuilder(
      animation: _animation.getController,
      builder: (BuildContext context, Widget? widget) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.diagonal3Values(
            _animation.getCircleSize.value,
            _animation.getCircleSize.value,
            1,
          ),
          child: Container(
            height: _circleD,
            width: _circleD,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(_circleD / 2),
              image: DecorationImage(
                image: AssetImage('assets/images/main_avatar.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Text(
                'AuthApp',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: _deviceHeight * 0.05,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _nameWidget() {
    return Container(
      child: Text(
        'John Doe',
        style: TextStyle(
          color: kPrimaryColor,
          fontSize: 35,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _logoutButton(BuildContext context) {
    return MaterialButton(
      minWidth: _deviceWidth * 0.38,
      height: _deviceHeight * 0.055,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
        side: BorderSide(
          color: kPrimaryColor,
          width: 3,
        ),
      ),
      child: Text(
        'LOG OUT',
        style: TextStyle(
          fontSize: 16,
          color: kPrimaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () {
        Navigator.pushReplacement(
          context,
          SlidePageRoute(AnimatedLoginPage()),
        );
      },
    );
  }
}
