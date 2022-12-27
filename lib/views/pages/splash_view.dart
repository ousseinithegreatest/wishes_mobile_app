import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wishes/views/pages/home.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      title: Text(
        "WIHES",
        style: GoogleFonts.croissantOne(
            fontSize: 70,
            // fontWeight: FontWeight.w400,
            color: Colors.white),
      ),
      backgroundColor: Colors.deepOrange,
      showLoader: true,
      loaderColor: Colors.white,
      navigator: Home(),
      durationInSeconds: 5,
    );
  }
}
