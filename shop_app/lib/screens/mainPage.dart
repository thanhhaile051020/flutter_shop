import 'package:flutter/material.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'loginpage.dart';

enum ScreenSize {
  extraLarge,
  large,
  medium,
  small,
}

class MainScreen extends StatelessWidget {
  final auth;
  MainScreen(this.auth);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return !auth.isAuth
            ? FutureBuilder(
                future: auth.tryAutoLogin(),
                builder: (context, snapshot) => LoginPage(),
              )
            : HomeScreen();
      },
    );
  }
}
