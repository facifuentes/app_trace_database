import 'package:flutter/material.dart';


class ItemListTile extends StatelessWidget {
  final title;
  final description;
  ItemListTile({this.title, this.description});
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 16),
        ),
        Text(
          description==null?"":description,
          style: TextStyle(
              color: Colors.black,
              fontSize: 16),
        ),
      ],
    );
  }
}
