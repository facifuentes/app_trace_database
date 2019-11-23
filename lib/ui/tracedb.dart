import 'package:flutter/material.dart';
import 'package:trace_database/ui/home.dart';
import 'package:trace_database/ui/splash_screen.dart';
import 'package:trace_database/utils/constants.dart';


class App extends StatelessWidget {
  // This widget is the root of the application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: Constants.appName,
        theme: ThemeData(
            primarySwatch: Colors.blue),
        initialRoute: Constants.root,
        routes: {
          Constants.root: (context) => SplashScreen(),
         Constants.homeRoute: (context) => HomeUI(),
        
        }
      );
  }
}