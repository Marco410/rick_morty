import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_morty/config/theme/style.dart';
import 'package:sizer_pro/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  SplashScreenState();

  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() {
    return Timer(
        const Duration(milliseconds: 3500), () => context.goNamed('home'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyle.blackSecondaryColor,
      body: Center(child: SvgPicture.asset("assets/logo.svg", height: 40.sp)),
    );
  }
}
