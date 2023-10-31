import 'package:flutter/material.dart';
import 'package:main_project/localStorage/shared_view.dart';
import 'package:main_project/routes/routes..dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        getData();
      },
    );
    super.initState();
  }

  bool isValid = false;

  void getData() async {
    var prefs = await Shared.getPrefs();
    isValid = prefs.getBool(onboardingKey) == null
        ? false
        : prefs.getBool(onboardingKey)!;
    if (isValid == false) {
      print("object");
      Navigator.pushNamed(context, onboardingRoute);
    } else {
      print("ksad;lkf;ksdfk");
      Navigator.pushNamed(context, homeRoute);
    }
    setState(() {});
  }

  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
      body: Center(
          child: FlutterLogo(
        size: 80,
      )),
    ));
  }
}
