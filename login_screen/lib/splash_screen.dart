import "package:flutter/material.dart";
import "package:login_screen/login_page.dart";

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State {
  @override
  @mustCallSuper
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                offset: Offset(10, 3),
                color: Colors.white,
                blurRadius: 10,
                spreadRadius: 10,
              )
            ],
          ),
          height: 205,
          width: 600,
          child: Image.asset(
            "assets/images/quickensol_cover.jpeg",
          ),
        ),
      ),
    );
  }
}
