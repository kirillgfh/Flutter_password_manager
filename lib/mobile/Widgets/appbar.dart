import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AppBar mobileAppbar() => AppBar(
      title: const Center(child: Text("M O B I L E")),
      automaticallyImplyLeading: false,
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.logout,
            color: Colors.white,
          ),
          onPressed: () {
            FirebaseAuth.instance.signOut();
          },
        )
      ],
    );
