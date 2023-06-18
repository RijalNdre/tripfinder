import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:travelgo/auth/register.dart';
import 'package:travelgo/page/beranda.dart';
import 'package:travelgo/page/navigasi.dart';
import 'package:http/http.dart' as http;
import 'package:travelgo/page/navigasi.dart';
import 'dart:convert';

import 'package:travelgo/services/auth_service.dart';

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //TODO : bikin tampilan login
        body: Container(
            margin: EdgeInsets.only(top: 150, left: 40, right: 40),
            child: ListView(
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 100,
                  height: 100,
                ),
                Container(
                  margin: EdgeInsets.only(top: 30, bottom: 20),
                  child: Text(
                    "Selamat datang",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF026490)),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10, top: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      GoogleAuth().signInWithGoogle().then((value) {
                        if (value.user != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => Navigasi(),
                            ),
                          );
                        }
                      });
                    },
                    child: Text('Login menggunakan google'),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Color(0xFF026490)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                        fixedSize: MaterialStatePropertyAll(Size(100, 40))),
                  ),
                ),
              ],
            )));
  }
}
