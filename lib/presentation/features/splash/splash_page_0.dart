// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import '../login/login_page.dart';

class SplashPage0 extends StatefulWidget {
  const SplashPage0({super.key});

  @override
  State<SplashPage0> createState() => _SplashPage0State();
}

class _SplashPage0State extends State<SplashPage0> {
  @override
  void initState() {
    navigateToHome();
    super.initState();
  }

  void navigateToHome() async {
    await Future.delayed(const Duration(seconds: 2));
    Navigator.of(context)
        .pushNamedAndRemoveUntil(LoginPage.routeName, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
