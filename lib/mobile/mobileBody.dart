// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_password_manager/mobile/mobileMainPage.dart';
import 'package:flutter_password_manager/mobile/mobileloginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'Widgets/BottomBar.dart';
import 'Widgets/appbar.dart';
import 'mobileGeneratePassword.dart';


class MyMobileBody extends StatefulWidget {

  @override
  State<MyMobileBody> createState() => _MyMobileBodyState();
}

class _MyMobileBodyState extends State<MyMobileBody> {
  final pages = [
    MobileGeneratePass(),
    MobileMainPage(),
    MobileLoginScreen(),
  ];
  final PageController pageController = PageController(initialPage: 0);


  @override
  Widget build(BuildContext context) {
    // switch (page) {
    //   case 0 : return MobileGeneratePass() ;
    //   case 1: return MobileMainPage();
    //   default : return MobileLoginScreen() ;
    // }
    return Scaffold(
      bottomNavigationBar: buildCurvedNavigationBar(),
      body: pages[page],
    );
  }



  CurvedNavigationBar buildCurvedNavigationBar() {
    return CurvedNavigationBar(
      // key: _bottomNavigationKey,
      index: page,
      height: 60.0,
      items: <Widget>[
        Icon(Icons.add, size: 30, color: Colors.white,),
        Icon(Icons.list, size: 30, color: Colors.white),
        Icon(Icons.logout, size: 30, color: Colors.white),
        // Icon(Icons.call_split, size: 30, color: Colors.white),
        // Icon(Icons.perm_identity, size: 30, color: Colors.white),
      ],
      color: (Colors.deepPurple.shade400), // back
      buttonBackgroundColor: Colors.deepPurple[400], //кнопка
      backgroundColor: Colors.purple.shade100, // tongue
      animationCurve: Curves.easeInOut,
      animationDuration: Duration(milliseconds: 600),
      onTap: (index) {
        setState(() {
          page = index;
          print(index);
        });
        if (index == 2){
          FirebaseAuth.instance.signOut();
            page = 1;
        }
      },
      letIndexChange: (index) => true,
    );
  }


}


