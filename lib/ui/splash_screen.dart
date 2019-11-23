import 'dart:async';

import 'package:flutter/material.dart';
import 'package:trace_database/utils/navigator.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () => AppNavigator.goToHome(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(child: Text("Bienvenido", style: TextStyle(color: Colors.white,fontSize: 30),),),
    );
  }
}
