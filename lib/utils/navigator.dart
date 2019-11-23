import 'package:flutter/material.dart';
import 'package:trace_database/utils/constants.dart';


class AppNavigator {
  static void goToHome(BuildContext context) {
    //Navigator.pushNamed(context, Constants.homeRoute);
    //Navigator.of(context).pushReplacementNamed(Constants.homeRoute);
    Navigator.of(context).pushNamedAndRemoveUntil(Constants.homeRoute, (Route<dynamic> route) => false);
  }

}
