import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../Home/HomePage.dart';

class SplashScreenForDirectLogin extends StatefulWidget {
  const SplashScreenForDirectLogin({super.key});

  @override
  State<SplashScreenForDirectLogin> createState() => _SplashScreenForDirectLoginState();
}

class _SplashScreenForDirectLoginState extends State<SplashScreenForDirectLogin> {
  // NotificationServices notificationServices = NotificationServices();
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/gif/loader.gif',
              fit: BoxFit.cover,
            ),
            // ignore: deprecated_member_use
            ColorizeAnimatedTextKit(
              // text: const ["Welcome to\nHeaven Of Cricket"],
              text: const ["Welcome to\nHeaven Of Cricket..!"],
              textStyle: const TextStyle(
                fontSize: 35.0,
              ),
              colors: const [
                Colors.purple,
                Colors.blue,
                Colors.yellow,
                Colors.red,
              ],
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
