// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, non_constant_identifier_names, avoid_print

import 'dart:convert';
import 'package:flutter/services.dart';

import 'package:crypto/crypto.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'Widgets/BottomBar.dart';
import 'Widgets/ShowStatusBar.dart';
import 'Widgets/appbar.dart';

var _password_gen;
var sp = [md5, sha1, sha256, sha224, sha512] ;
var sp2= ['md5', 'sha1', 'sha256', 'sha224', 'sha512'] ;


class MobileGeneratePass extends StatefulWidget {
  const MobileGeneratePass({Key? key}) : super(key: key);

  @override
  _MobileGeneratePassState createState() => _MobileGeneratePassState();
}

class _MobileGeneratePassState extends State<MobileGeneratePass> {
  final _password_gen_controller = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.purple[100],
        // appBar: mobileAppbar(),
        // bottomNavigationBar: BuildCurvedNavigationBar(),
        body: Column(
          children: [
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.deepPurpleAccent.shade100,
                    border: Border.all(color: Colors.purple, width: 2),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: TextFormField(
                    controller: _password_gen_controller,
                    cursorColor: Colors.white,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        icon: const Icon(
                          Icons.person,
                          color: Colors.purple,
                        ),
                        hintText: 'Enter something',
                        hintStyle: TextStyle(color: Colors.grey.shade300),
                        border: InputBorder.none),
                    onChanged: (text) {
                      setState(() {
                        _password_gen = utf8.encode('$text');
                        print('text field changed: ${_password_gen}');

                      });
                    },
                  ),
                ),
              ),
            ),
            Expanded(
                child: ListView.builder(
                itemCount: sp.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () async {
                        await Clipboard.setData(ClipboardData(text: '${sp[index].convert(_password_gen ?? [])}'));
                        showErrorBar(context, 'copied to сlipboard', Colors.green, 0.02);

                      },
                      child: Container(
                        color: Colors.deepPurple[300],
                        height: 120,
                        child: Center(child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("${sp2[index]}", style: TextStyle(fontSize: 40, color: Colors.white),),
                            Text("${sp[index].convert(_password_gen ?? [])}", style: TextStyle(fontSize: 20, color: Colors.white),),
                          ],
                        )),
                      ),
                    ),
                  );
                }))
          ],
        ));
  }
}


//
// child: Column(
// children: [
// Container(
// color: Colors.deepPurple[300],
// height: 120,
// child: Center(child: Column(
// children: [
// Text("Sha256", style: TextStyle(fontSize: 40, color: Colors.white),),
// Text(_password_gen, style: TextStyle(fontSize: 20, color: Colors.white),),
// ],
// )),
// ),
// Container(
// color: Colors.deepPurple[300],
// height: 120,
// child: Center(child: Column(
// children: [
// Text("MD5", style: TextStyle(fontSize: 40, color: Colors.white),),
// Text(_password_gen, style: TextStyle(fontSize: 20, color: Colors.white),),
// ],
// )),
// ),
// Container(
// color: Colors.deepPurple[300],
// height: 120,
// child: Center(child: Column(
// children: [
// Text("Sha256", style: TextStyle(fontSize: 40, color: Colors.white),),
// Text(_password_gen, style: TextStyle(fontSize: 20, color: Colors.white),),
// ],
// )),
// ),
// ],
// )
// ),