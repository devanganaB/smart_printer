import 'package:flutter/material.dart';
import 'package:smart_printer/Screens/LoginPage.dart';

class GetstartedScreen extends StatefulWidget {
  const GetstartedScreen({super.key});

  @override
  State<GetstartedScreen> createState() => _GetstartedScreenState();
}

class _GetstartedScreenState extends State<GetstartedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/getStarted.jpg'),
                  fit: BoxFit.cover)),
          child: Center(
              child: Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: ElevatedButton(
              onPressed: () {
                // print('Button Pressed');
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LoginPage();
                }));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 25, 95, 215),
              ),
              child: const Text('Get Started'),
            ),
          ))),
    );
  }
}
