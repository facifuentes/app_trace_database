import 'package:flutter/material.dart';
import 'dart:io';
import 'package:intl/intl.dart';

class CommonsSM {
  InputDecoration inputDecorationSM(
      String hintext, String labeltext, IconData icon, Color colorError) {
    return InputDecoration(
      errorStyle: TextStyle(color: colorError),
      border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
           Radius.circular(20.0),
        ),
        borderSide: BorderSide(
          color: Colors.black,
          width: 1.0,
        ),
      ),
      filled: true,
      icon: icon != null ? Icon(icon) : null,
      hintText: hintext,
      labelText: labeltext,
    );
  }

  showAlertDialogOneButton(context, title, message) {
    // set up the button
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text("Aceptar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String typeofDevice() {
    String os = "";
    if (Platform.isMacOS) {
      os = "DEVICE_TYPE_IOS";
    } else {
      os = "DEVICE_TYPE_ANDROID";
    }
    return os;
  }

  String formatDate(String date) {
    DateTime initialTimeSession = DateTime.parse(date);

    return DateFormat("yyyy-MMM-dd").format(initialTimeSession);
  }

  String formatDateWhitTime(String date) {
    DateTime initialTimeSession = DateTime.parse(date);

    return DateFormat("yyyy-MMM-dd  HH:mm ").format(initialTimeSession);
  }

  bool differenceDays(String date1, String date2) {
    bool difneg = false;
    if (date1 != null) {
      DateTime dateTime1 = DateTime.parse(date1);
      DateTime dateTime2 = DateTime.parse(date2);
       difneg = dateTime2.difference(dateTime1).inDays.isNegative;
    }
    return difneg;
  }

  
  String getState(String value) {
    String state = "";
    switch (value) {
      case 'I':
        state = "Iniciado";
        break;
      case 'F':
        state = "Finalizado";
        break;
      case 'P':
        state = "Pagado";
        break;
    }
    return state;
  }

    String initials(String name) {
    List words = name.split(" ");
    String initial = "";
    int i = 0;
    words.forEach((f) {
      if (i < 2) {
        initial += f[0];
        i++;
      } else {
        return;
      }
    });
    return initial;
  }
}
