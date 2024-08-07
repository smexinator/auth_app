import 'package:auth_app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:auth_app/constants.dart';
import 'package:auth_app/utilities/animations/login_page_animation.dart'; // Ensure this import is correct
import 'package:auth_app/utilities/page_routes/slide_page_route.dart';

class AnimatedLoginPage extends StatefulWidget {
  @override
  _AnimatedLoginPageState createState() => _AnimatedLoginPageState();
}

class _AnimatedLoginPageState extends State<AnimatedLoginPage>
    with SingleTickerProviderStateMixin 
 {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController( 

      vsync: this, // Ensure vsync is used correctly
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
    return LoginPage(_controller, this); // Pass both required arguments
  }
}


class LoginPage extends StatelessWidget {
  final AnimationController _controller;
  final TickerProvider _vsync;
  late final EnterAnimation _animation;
  late final double _deviceHeight;
  late final double _deviceWidth;

  LoginPage(this._controller, this._vsync) {
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
      body: Center(
        child: Container(
          width: _deviceWidth * 0.9,
          height: _deviceHeight * 0.6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _avatarWidget(),
              SizedBox(height: _deviceHeight * 0.03),
              _loginButton(context), // Pass context here
            ],
          ),
        ),
      ),
    );
  }

  Widget _avatarWidget() {
    double _circleD = _deviceHeight * 0.25;
    return AnimatedBuilder(
      animation: _controller, // Ensure correct use of the animation controller
      builder: (BuildContext context, Widget? child) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.diagonal3Values(
            _animation.getCircleSize.value, // Ensure correct getter is used
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

  Widget _loginButton(BuildContext context) {
    return MaterialButton(
      minWidth: _deviceWidth * 0.5,
      height: _deviceHeight * 0.06,
      color: kPrimaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Text(
        'LOGIN',
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () {
        Navigator.pushReplacement(
          context,
          SlidePageRoute(
              AnimatedHomePage()), // Ensure `AnimatedHomePage` is defined
        );
      },
    );
  }
}
