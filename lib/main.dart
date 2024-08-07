import 'package:flutter/material.dart';
import 'package:auth_app/constants.dart';
import 'package:auth_app/pages/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.light(
          secondary: kSecondaryColor,
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.black), // Adjust as needed
          bodyMedium: TextStyle(color: Colors.grey), // Adjust as needed
          titleLarge: TextStyle(fontWeight: FontWeight.bold), // Adjust as needed
        ),
      ),
      home: AnimatedLoginPage(),
    );
  }
}
