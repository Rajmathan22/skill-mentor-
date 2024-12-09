import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:skillzmentors/Components/bottom_navigation_bar/custom_bottom_appbar.dart';
import 'package:skillzmentors/config/Images/jobes_image.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 2000,
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipOval(
            child: Container(
              width:
                  120,
              height:
                  120,
              child: Image.asset(
                JobsImage.splash_image,
                fit: BoxFit
                    .cover,
              ),
            ),
          ),
          const SizedBox(height: 20),
          RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'Skillz',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                TextSpan(
                  text: 'Me',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                TextSpan(
                  text: 'ntors',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      splashIconSize: 250,
      backgroundColor: Colors.white,
      splashTransition: SplashTransition.fadeTransition,
      animationDuration:const Duration(seconds: 1),
      nextScreen: CustomBottomAppbar(),
    );
  }
}
