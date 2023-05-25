// ignore_for_file: library_private_types_in_public_api, file_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this);
    Timer(Duration(seconds: 1), (){} );
    controller.addListener(() {
      if (controller.value > 0.99){
        controller.stop();
        Navigator.pushReplacementNamed(context, '/');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      body: Content(),
    );
  }

  Widget Content() => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // const Center(child: Text('БизнесТрэйд', style: TextStyle(fontSize: 50, fontFamily: "MontserratAlternates", fontWeight: FontWeight.w500),)),
        SizedBox(
          // width: MediaQuery.of(context).size.width ,
          height: MediaQuery.of(context).size.height * 0.95,
          child: Lottie.asset(
                  'Assets/animations/lock.json',
                  controller: controller,
                  onLoaded: (composition) {
                    controller
                      ..duration = composition.duration
                      ..forward();
                  }),
        ),
      ],
    ),
  );
}
