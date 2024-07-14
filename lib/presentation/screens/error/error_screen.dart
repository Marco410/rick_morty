import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:rick_morty/config/theme/style.dart';
import 'package:sizer_pro/sizer.dart';

class ErrorScreen extends StatefulWidget {
  final GoException? error;

  const ErrorScreen({super.key, this.error});

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyle.blackSecondaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset("assets/animations/not_found.json",
                height: 220, fit: BoxFit.contain),
            Text(
              "Página no encontrada",
              textAlign: TextAlign.center,
              style: TxtStyle.headerStyle.copyWith(fontSize: 9.sp),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () => context.goNamed("home"),
              child: Text(
                "Ir al inicio",
                textAlign: TextAlign.center,
                style: TxtStyle.labelStyle.copyWith(
                    decoration: TextDecoration.underline,
                    color: ColorStyle.primaryColor,
                    fontSize: 6.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
