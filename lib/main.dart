import 'package:flutter/material.dart';
import 'package:no_to_do_app/ui/Home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NoToDo',
      home: Home(),
    );
  }

}

