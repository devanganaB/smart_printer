import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_printer/Widgets/widgets.dart';
class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Color(0xFFA0B5EB), Color(0xFFC9F0E4)])
            ),
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Smart Printer',
                  style: TextStyle(
                    fontFamily: 'Times New Roman',
                    fontSize: 38,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 50,),
                const Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                UserFormField(icon: Icon(Icons.person_pin_outlined),labelText: 'Name',),
                UserFormField(icon: Icon(Icons.email),labelText: 'E-mail',),
                UserFormField(icon: Icon(Icons.contact_phone),labelText: 'Contact Number',),
                UserFormField(icon: Icon(Icons.abc),labelText: 'Branch',),
                UserFormField(icon: Icon(Icons.add_circle_outline_outlined),labelText: 'Division',),
                UserFormField(icon: Icon(Icons.library_books),labelText: 'Library Card No.',),
                UserFormField(icon: Icon(Icons.lock),labelText: 'Password',),
                UserFormField(icon: Icon(Icons.lock),labelText: 'Confirm Password',),
                ElevatedButton(onPressed: (){}, child: const Text('Create Your Smart Printer Account')),
                ElevatedButton(onPressed: (){}, child: const Text('Sign-In Now')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
