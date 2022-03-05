import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  UserPage({Key? key, required this.name, required this.urlImage})
      : super(key: key);

  String name;
  String urlImage;
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.name.toString()),
    );
  }
}
