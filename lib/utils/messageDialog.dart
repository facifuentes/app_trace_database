import 'package:flutter/material.dart';
import 'package:trace_database/models/errorapi_model.dart';

import 'package:trace_database/utils/constants.dart';

class MessageDialog {
  Future<bool> warnUserCreationConfirmed(
      BuildContext context, String message) async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(Constants.informationHelp),
              content: Text(message),
              actions: <Widget>[
                FlatButton(
                  child: const Text(Constants.acceptLabel),
                  onPressed: () {
                    Navigator.of(context).pop(true);
           
                  },
                ),
              ],
            );
          },
        ) ??
        false;
  }

  Future<bool> warnCreationConfirmed(BuildContext context, String message,
      String gotoUI, bool closeScreen) async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(Constants.informationHelp),
              content: Text(message),
              actions: <Widget>[
                FlatButton(
                  child: const Text(Constants.acceptLabel),
                  onPressed: () {
                    //Cierra el popup
                    Navigator.of(context).pop(true);
                    //Cerrar la pantalla actual
                    if (closeScreen) {
                      Navigator.pop(context);
                    }
                    //Redirige a una pantalla
                    if (gotoUI.isNotEmpty) {
                      Navigator.pushNamed(context, gotoUI);
                    }
                  },
                ),
              ],
            );
          },
        ) ??
        false;
  }



  Future<bool> warnIssue(
      BuildContext context, ErrorApiResponse errorApiResponse) async {
    return await showDialog<bool>(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(Constants.informationHelp),
              content: Text(errorApiResponse.message),
              actions: <Widget>[
                FlatButton(
                  child: const Text(Constants.acceptLabel),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            );
          },
        ) ??
        false;
  }

  Future<bool> warnAboutInvalidData(GlobalKey<FormState> _formKey,
      bool _formWasEdited, BuildContext context, String message) async {
    final FormState form = _formKey.currentState;
    if (form == null || !_formWasEdited || form.validate()) return true;

    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(Constants.informationHelp),
              content: Text(message),
              actions: <Widget>[
                FlatButton(
                  child: const Text(Constants.acceptLabel),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                )
              ],
            );
          },
        ) ??
        false;
  }
}
