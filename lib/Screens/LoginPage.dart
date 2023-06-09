import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                //Some Issue With Image Size
                image: AssetImage('assets/images/Login.png'),
                fit: BoxFit.cover)),
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const Text(
            //   'Smart Printer',
            //   style: TextStyle(
            //     fontFamily: 'Times New Roman',
            //     fontSize: 38,
            //     fontWeight: FontWeight.w500,
            //   ),
            // ),
            const SizedBox(
              height: 100,
            ),
            const Text(
              'Login To Your Account',
              style: TextStyle(
                fontFamily: 'Times New Roman',
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  labelText: 'E-mail',
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  labelText: 'Password',
                ),
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5200FF),
                ),
                child: const Text('Login'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Login With',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 75,
                  width: 75,
                  child: Card(
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: IconButton(
                      icon: Image.asset('assets/images/google.png'),
                      onPressed: () {},
                    ),
                  ),
                ),
                SizedBox(
                  height: 75,
                  width: 75,
                  child: Card(
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: IconButton(
                      icon: Image.asset('assets/images/facebook.png'),
                      onPressed: () {},
                    ),
                  ),
                ),
                SizedBox(
                  height: 75,
                  width: 75,
                  child: Card(
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: IconButton(
                      icon: Image.asset('assets/images/twitter.png'),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account ?",
                  style: TextStyle(fontSize: 16),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Create one",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
