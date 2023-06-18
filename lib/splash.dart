import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logo.png',
            width: 150,
            height: 150,
          ),
          SizedBox(height: 16.0),
          Text(
            'Welcome',
            style: TextStyle(
              fontFamily: 'FontPoppins',
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Color(0xff026490),
            ),
            textAlign: TextAlign.center,
          )
        ],
      )),
    );
  }
}
