import 'package:disposur/constant.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:disposur/views/login.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Disposur',
    routes: {
      Login.routeName: (context) => Login()
    },
    theme: ThemeData(
      primaryColor: AppColor().colorTertiary,
    ),
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 3,
      title: Text(
        'DISPOSUR',
        style: TextStyle(
            color: Colors.white, fontSize: 32, fontWeight: FontWeight.w500),
      ),
      photoSize: 128,
      backgroundColor: AppColor().colorTertiary,
      loaderColor: AppColor().colorTertiary,
      navigateAfterSeconds: Login(),
    );
  }
}
