import 'package:flutter/material.dart';
import 'package:smart_printer/Screens/SideMenu.dart';

class dummy extends StatelessWidget {
  const dummy({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: SideMenu(),
        appBar: AppBar(
          title: Text(
            'meow',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
        ),
      ),
    );
  }
}
