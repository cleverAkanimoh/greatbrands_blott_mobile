import 'package:greatbrands_blott_mobile/app_config.dart';
import 'package:greatbrands_blott_mobile/helpers/navigator_push.dart';
import 'package:flutter/material.dart';
import 'package:greatbrands_blott_mobile/screens/legal.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  void loadApp() {
    Future.delayed(const Duration(seconds: 3),
        () => NavigatorPush.pushReplace(page: const LegalName()));
  }

  @override
  void initState() {
    loadApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(whiteSpace),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.black,
        child: Center(
          child: SizedBox(
            height: 188,
            width: 188,
            child: Image.asset('assets/images/logo.png'),
          ),
        ),
      ),
    );
  }
}
