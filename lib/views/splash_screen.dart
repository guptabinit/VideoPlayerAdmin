import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'dart:async';
import 'home_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  // change screen
  changeScreen() {

    var count = 1;

    var authState = FirebaseAuth.instance.authStateChanges();

    Future.delayed(const Duration(seconds: 2), () {

      authState.listen((User? user) async {

        if(count == 1){
          if(user == null && mounted){
            Get.offAll(() => const LoginScreen());
            count++;
          } else {
            Get.offAll(() => const HomeScreen());
            count++;
          }
        }else{
        }

      });

    });
  }

  @override
  void initState() {
    super.initState();
    changeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.redAccent,
          ),
        ),
      ),
    );
  }
}