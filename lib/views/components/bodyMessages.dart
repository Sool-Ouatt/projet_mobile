import 'package:flutter/material.dart';
import '../../constants.dart';

class BodyMessages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // It will provie us total height  and width of our screen
    Size size = MediaQuery.of(context).size;
    // it enable scrolling on small device
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Messages"),
          SizedBox(height: kDefaultPadding),
        ],
      ),
    );
  }
}
