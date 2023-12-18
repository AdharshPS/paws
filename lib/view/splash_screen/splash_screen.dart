import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:paws_app/view/bottom_navigator_screen/bottom_navigator_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2)).then(
      (value) => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNavigationBarScreen(),
        ),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset("assets/animations/paws_animation.json"),
        // Text(
        //   "PAWS",
        //   style: TextStyle(
        //     fontSize: 30,
        //     fontWeight: FontWeight.w800,
        //   ),
        // ),
      ),
    );
  }
}
