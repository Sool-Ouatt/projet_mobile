import 'package:flutter/material.dart';
import 'package:samadeukuway/views/pages/detailsLogement.dart';
import 'views/pages/myHome.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sama Deukuway',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHome(),
      routes: {
        DetailsLogement.routeName: (context) => DetailsLogement(),
      },
    );
  }
}
