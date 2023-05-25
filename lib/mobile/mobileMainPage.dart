// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../sharedPref.dart';
import 'Widgets/BottomBar.dart';
import 'Widgets/ShowStatusBar.dart';
import 'Widgets/appbar.dart';
var _prefs = SharedPreferences.getInstance();
var   _passwordCheckController = TextEditingController();

class MobileMainPage extends StatefulWidget {
  const MobileMainPage({Key? key}) : super(key: key);

  @override
  _MobileMainPageState createState() => _MobileMainPageState();
}

class _MobileMainPageState extends State<MobileMainPage> {
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  void dispose() {
    _portalController.dispose();
    _passwordController.dispose();
    // _passwordCheckController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;


    return Scaffold(
      backgroundColor: Colors.purple[100],
      // bottomNavigationBar: BuildCurvedNavigationBar(),
      // appBar: mobileAppbar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              height: 60,
              color: Colors.deepPurple[400],
              child: Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("signed as ${user.email}", style: TextStyle(fontSize: 30, color: Colors.white),),
                  IconButton(onPressed: () async {
                    final prefs = await _prefs;
                    setState(() {
                      prefs.remove('list');
                      list = [];
                    });
                  },
                  icon: Icon(Icons.delete_forever, size: 35.0,),
                  color: Colors.white,)
                ],
              )),
            ),
          ),
          AddObject(),
          Expanded(
              child: list.isNotEmpty ? ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            color: Colors.deepPurple[300],
                            height: 215,
                            child: Center(child: Column(
                              children: [
                                Text("Portal: ${list[index][0]}", style: TextStyle(fontSize: 25, color: Colors.white),),
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
                                        obscureText: true,
                                        controller: _passwordCheckController,
                                        cursorColor: Colors.white,
                                        style: const TextStyle(color: Colors.white),
                                        decoration: InputDecoration(
                                            icon: const Icon(
                                              Icons.lock,
                                              color: Colors.purple,
                                            ),
                                            hintText: 'your password',
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
                                    onTap: () {
                                      checkPassword(index, _passwordCheckController.text);
                                    },
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
                                            'Check...',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 24),
                                          )),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                          ),
                        ),
                      ],
                    );
                  })

            : SizedBox()
          )
        ],
      ),
    );
  }


  final _portalController = TextEditingController();
  final _passwordController = TextEditingController();
  Widget AddObject() => Column(
    children: [
      TextFormField(
        controller: _portalController,
        cursorColor: Colors.white,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
            icon: const Icon(
              Icons.wb_cloudy_outlined,
              color: Colors.purple,
            ),
            hintText: 'what is the Pass for?...',
            hintStyle:
            TextStyle(color: Colors.grey.shade300),
            border: InputBorder.none),
      ),
      const SizedBox(
        height: 15,
      ),
      TextFormField(
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
            border: InputBorder.none),),
      GestureDetector(
        onTap: submitObject,
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
                'Submit',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              )),
        ),
      ),
    ],
  );

  void submitObject() async {
    bool _neDublicat = true;
    final prefs = await _prefs;
    for (int i = 0; i < list.length; i++) {
      if (_portalController.text == list[i][0]) {
        _neDublicat = false;
        showErrorBar(context, 'portal already exist', Colors.red, 0.02);
        break;
      }
    }
    if (_neDublicat && _portalController.text != '' && _passwordController.text != '') {
      setState(() {
        var bytes = utf8.encode(_passwordController.text); // data being hashed
        var digest = md5.convert(bytes);
        list.add([_portalController.text, digest.toString()]);
        print(jsonEncode(map));
        SharedPref().saveString('list', jsonEncode(map));
        print('${prefs.getString('list')} , $list');
      });
    }
  }

  void checkPassword(int index, String text) {
    var bytes = utf8.encode(text); // data being hashed
    var digest = md5.convert(bytes);
    print(digest);
    print(list[index][1]);

    digest.toString() == list[index][1]
        ? showErrorBar(context, 'Correct pass!', Colors.green, 0.02)
        : showErrorBar(context, 'Incorrect pass!', Colors.red, 0.02);

  }
}


