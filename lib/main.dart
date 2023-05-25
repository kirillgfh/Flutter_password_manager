import 'dart:async';
import 'dart:convert';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_password_manager/homePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Splash.dart';
import 'firebase_options.dart';
import 'mobile/mobileBody.dart';
import 'mobile/mobileloginPage.dart';

int page = 1;
var list = [];
Map<String, dynamic> map = {'list': list};

var _prefs = SharedPreferences.getInstance();

class MyApp extends StatefulWidget  {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      _asyncStart();
    });

    print('start init main');
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
          fontFamily: 'Poppins'
      ),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      // theme: lightTheme,
      // darkTheme: darkTheme,
      // themeMode: themeManager.themeMode,
      initialRoute: '/splash',
      routes: {
        '/':(BuildContext context) => HomePage(),
        '/splash':(BuildContext context) => SplashScreen(),
        '/mobileBuilder':(BuildContext context) => MyMobileBody(),
        // '/settings':(BuildContext context) => Settings(),
        // '/search':(BuildContext context) => SearchPage(),
        // '/place_list':(BuildContext context) => PlaceListPage(),
        // '/place':(BuildContext context) => PlacePage(PlaceId: '1')
      },
    );
  }

  void _asyncStart() async {

    final prefs = await _prefs;
    // prefs.remove('list');
    // print(jsonDecode(prefs.getString('list') ?? ''));
    list = jsonDecode(prefs.getString('list') ?? '')['list'] ?? [];
    // rad = await prefs.getDouble('rad') ?? 0.35;
    // help = await prefs.getBool('help') ?? true;
    print('_asyncStart is over');
    print(list);
    print(prefs.getString('list'));
  }



}
// late Box box;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp( options: DefaultFirebaseOptions.currentPlatform,);

// Ideal time to initialize
//   await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  runApp(MyApp());

}


