// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';
import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'Widgets/ShowStatusBar.dart';

class MobileLoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

var defaultContainerDecoration = const BoxDecoration(
    color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(10))
);

class _LoginScreenState extends State<MobileLoginScreen> {
  // text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String errorMessage = '';

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      setState(() {
        errorMessage = '';
      });
    } on FirebaseAuthException catch (e) {
      print(e.message!);
      setState(() {
        if (kIsWeb) {
          print('ЯЙЦААААААААААА');
          errorMessage = e.message!.split('/')[1].substring(0, e.message!.split('/')[1].length - 2);
        }
        else if (Platform.isAndroid){
          FocusManager.instance.primaryFocus?.unfocus();
          errorMessage = e.message!;
        }
      });

      if (e.message!.contains('not-found') || e.message!.contains('no user record')) {
        setState(() {
          errorMessage = '';
        });
        var _alphabet = ['A'];
        var _data = utf8.encode('\$@Lt' + _passwordController.text.trim()); // data being hashed
        var _convertData = md5.convert(_data);
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _convertData.toString(),
        );
      }

      if (errorMessage != '') {
        showErrorBar(context, errorMessage);
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.purple[100],
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            child: SvgPicture.asset(
              'Assets/images/loginPageMobile/topAbstract.svg',
              width: size.width,
            ),
          ),
          Positioned(
            bottom: 0,
            child: SvgPicture.asset(
              'Assets/images/loginPageMobile/downAbstract.svg',
              width: size.width,
            ),
          ),

          Center(
            child: SizedBox(
              height: size.height,
              width: size.width * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 400.0,
                      // maxWidth: 1300.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SvgPicture.asset(
                          'Assets/images/loginPageMobile/defender.svg',
                          height: 250,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.deepPurpleAccent.shade100,
                                border:
                                    Border.all(color: Colors.purple, width: 2),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10))),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: TextFormField(
                                controller: _emailController,
                                cursorColor: Colors.white,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    icon: const Icon(
                                      Icons.person,
                                      color: Colors.purple,
                                    ),
                                    hintText: 'Email',
                                    hintStyle:
                                        TextStyle(color: Colors.grey.shade300),
                                    border: InputBorder.none),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.deepPurpleAccent.shade100,
                                border:
                                    Border.all(color: Colors.purple, width: 2),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10))),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: TextFormField(
                                controller: _passwordController,
                                style: const TextStyle(color: Colors.white),
                                cursorColor: Colors.white,
                                obscureText: true,
                                decoration: InputDecoration(
                                    icon: const Icon(
                                      Icons.lock,
                                      color: Colors.purple,
                                    ),
                                    suffixIcon: const Icon(
                                      Icons.remove_red_eye,
                                      color: Colors.purple,
                                    ),
                                    hintText: 'Password',
                                    hintStyle:
                                        TextStyle(color: Colors.grey.shade300),
                                    border: InputBorder.none),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: signIn,
                            child: Container(
                              padding: const EdgeInsets.all(25),
                              decoration: BoxDecoration(
                                color: const Color(0xFF773DDD),
                                border:
                                    Border.all(color: Colors.purple, width: 2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                  child: Text(
                                'Sign in',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24),
                              )),
                            ),
                          ),
                        ),

                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );

  }

  // void showErrorBar(BuildContext context, String errorMessage, [var color]) {
  //   Flushbar(
  //
  //     flushbarPosition: FlushbarPosition.TOP,
  //     margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.11),
  //     messageText: Container(child: Center(child: Text(errorMessage, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),)),),
  //     // leftBarIndicatorColor: Colors.blue[300],
  //     duration: const Duration(seconds: 4),
  //     backgroundColor: color ?? Colors.red,
  //   ).show(context);
  // }

}
