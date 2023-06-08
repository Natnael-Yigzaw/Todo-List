import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../provider/introchecker.dart';
import 'homescreen.dart';
import 'onbordingscreen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
     /*Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      );*/
     navigateToNextScreen();
    });
  }

    void navigateToNextScreen() async {
    bool isFirstTime = await SharedPreferencesService.getIsFirstTime();

    if (isFirstTime) {
      await SharedPreferencesService.setIsFirstTime(false);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
   
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/todolist.png', 
              width: 80,
              height: 80,
            ),
          ],
        ),
      ),
    );
  }
}
