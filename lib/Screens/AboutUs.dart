import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF5200FF),
      ),
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child:  Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Spacer(flex: 1,),
            SizedBox(height: MediaQuery.sizeOf(context).height*0.15,),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('About Us',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'times new roman'
                  ),
                ),
                SizedBox(width: 150,)
              ],
            ),
            const SizedBox(height: 50,),
            const Padding(
              padding:  EdgeInsets.symmetric(horizontal:20.0),
              child:  Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}