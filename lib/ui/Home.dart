import 'package:flutter/material.dart';
import 'package:no_to_do_app/ui/NoToDoScreen.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('No to-do'),
        centerTitle: true,
        backgroundColor: Colors.black54,
      ),
    body: new NoToDoScreen(),
    );
  }
}
