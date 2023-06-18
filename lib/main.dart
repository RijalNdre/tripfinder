import 'package:flutter/material.dart';
import 'package:travelgo/auth/login.dart';
import 'package:travelgo/page/beranda.dart';
import 'package:travelgo/page/navigasi.dart';
import 'package:travelgo/page/ulasan.dart';
import 'package:travelgo/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final pref = await SharedPreferences.getInstance();
  final result = pref.getString("id");
  if (result == null) {
    return runApp(
      MyApp(
        widget: LoginApp(),
      ),
    );
  } else {
    final email = pref.getString("email");
    return runApp(
      MyApp(
        widget: Beranda(email: email ?? ""),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  final Widget widget;
  const MyApp({
    super.key,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'TravelGo',
        theme: ThemeData(fontFamily: 'FontPoppins'),
        home: widget,
        debugShowCheckedModeBanner: false,
        initialRoute: '/splash',
        routes: {
          '/splash': ((context) => SplashScreen()),
          '/login': ((context) => LoginApp()),
          '/navigasi': ((context) => Navigasi())
        });
  }
}
