// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_password_manager/desktop/desktopBody.dart';
import 'package:flutter_password_manager/mobile/mobileBody.dart';
import 'package:flutter_password_manager/mobile/mobileloginPage.dart';
import 'package:flutter_password_manager/responsiveLayout.dart';
import 'package:page_transition/page_transition.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapwhot){
            if (snapwhot.hasData) {
              return ResponsiveLayout(
                mobileBody: MyMobileBody(),
                desktopBody: MyDesktopBody(),
              );
            } else {
              return ResponsiveLayout(
                mobileBody: MobileLoginScreen(),
                desktopBody: MobileLoginScreen(),
              );
            }
          }
        )
    );
  }
}
