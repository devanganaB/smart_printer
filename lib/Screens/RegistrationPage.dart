import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_printer/Screens/HomePage.dart';
//import 'package:smart_printer/Screens/HomePage.dart';
import 'package:smart_printer/Screens/LoginPage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  TextEditingController divisionController = TextEditingController();
  TextEditingController libraryCardController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  Future signup(String email, String password) async {
    if (password != confirmPasswordController.text) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Registration Error'),
          content: const Text('Password and Confirm Password do not match.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else if (dropdownValueBranch == 'Branch') {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Registration Error'),
          content: const Text('Please Select Your Branch'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else if (dropdownValueDiv == 'Division') {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Registration Error'),
          content: const Text('Please Select Your Division'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        registerUser(
            nameController.text.trim(),
            contactController.text.trim(),
            dropdownValueBranch,
            dropdownValueDiv,
            libraryCardController.text.trim());
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const HomePage();
        }));
      } on FirebaseAuthException catch (e) {
        Fluttertoast.showToast(
            msg: 'Account is already created',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }

      return;
    }
  }

  String dropdownValueBranch = 'Branch';
  String dropdownValueDiv = 'Division';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient:
                LinearGradient(colors: [Color(0xFFA0B5EB), Color(0xFFC9F0E4)])),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                const Center(
                  child: Text(
                    'Smart Printer',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildTextField('Name', nameController, Icons.person,
                          TextInputType.name),
                      buildTextField('Email', emailController, Icons.email,
                          TextInputType.emailAddress),
                      buildTextField('Contact Number', contactController,
                          Icons.phone, TextInputType.phone),
                      // buildTextField(
                      //     'Branch', branchController, Icons.business),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 60,
                        width: 450,
                        child: DropdownButtonFormField(
                          padding: EdgeInsets.symmetric(horizontal: 56),
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            filled: true,
                            fillColor: Colors.transparent,
                          ),
                          value: dropdownValueBranch,
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValueBranch = newValue!;
                            });
                          },
                          items: <String>[
                            'Branch',
                            'AIDS',
                            'CMPN',
                            'INFT',
                            'ETRX',
                            'EXTC',
                            'AURO',
                            'INST',
                            'MCA',
                            'ME',
                            'ECS'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(fontSize: 20),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 60,
                        width: 450,
                        child: DropdownButtonFormField(
                          padding: EdgeInsets.symmetric(horizontal: 56),
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            filled: true,
                            fillColor: Colors.transparent,
                          ),
                          value: dropdownValueDiv,
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValueDiv = newValue!;
                            });
                          },
                          items: <String>['Division', 'A', 'B', 'C', 'D', 'E']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(fontSize: 20),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      // buildTextField(
                      //     'Division', divisionController, Icons.location_city),
                      buildTextField('Library Card No', libraryCardController,
                          Icons.credit_card, TextInputType.number),
                      buildPasswordField(
                          'Password', passwordController, obscurePassword),
                      buildPasswordField('Confirm Password',
                          confirmPasswordController, obscureConfirmPassword,
                          isConfirm: true),
                      const SizedBox(height: 8),
                      const Text(
                        'Password must be at least 6 characters',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            String email = emailController.text;
                            String password = passwordController.text;
                            //registerUser(
                            //  name, contact, branch, division, libraryCardNo);
                            signup(email, password);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          // primary: Color(0xFF5200FF),
                          // onPrimary: Colors.white,
                          backgroundColor: const Color(0xFF5200FF),
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text('Create Your Smart Printer Account'),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Already have an account?',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          // print('button pushed');
                          Navigator.pop(context);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const LoginPage();
                          }));
                          // Handle sign-in button press
                        },
                        style: ElevatedButton.styleFrom(
                          // primary: Color(0xFF5200FF),
                          // onPrimary: Colors.white,
                          backgroundColor: const Color(0xFF5200FF),
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text('Sign-In Now'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller,
      IconData icon, TextInputType keyboard) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: 264,
      height: 56,
      child: TextFormField(
        keyboardType: keyboard,
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  Widget buildPasswordField(
      String label, TextEditingController controller, bool obscureText,
      {bool isConfirm = false}) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: 264,
      height: 56,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: const Icon(Icons.lock),
          suffixIcon: isConfirm
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      obscureConfirmPassword = !obscureConfirmPassword;
                    });
                  },
                  child: Icon(obscureConfirmPassword
                      ? Icons.visibility_off
                      : Icons.visibility),
                )
              : GestureDetector(
                  onTap: () {
                    setState(() {
                      obscurePassword = !obscurePassword;
                    });
                  },
                  child: Icon(obscurePassword
                      ? Icons.visibility_off
                      : Icons.visibility),
                ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter $label';
          }
          if (isConfirm && value != passwordController.text) {
            return 'Passwords do not match';
          }
          if (!isConfirm && value.length < 6) {
            return 'Password must be at least 6 characters';
          }
          return null;
        },
      ),
    );
  }

  void registerUser(
    String name,
    String contact,
    String branch,
    String division,
    String libraryCardNo,
  ) async {
    // Perform registration logic here
    var ref = FirebaseFirestore.instance
        .collection('Users Details')
        .doc(emailController.text);
    ref.set({
      'NAME': name,
      'CONTACT': contact,
      'BRANCH': branch,
      'DIVISION': division,
      'LIB-CARD_NO': libraryCardNo
    });
  }
}

Widget form() {
  return Container();
}

void main() {
  runApp(const MaterialApp(
    home: RegisterPage(),
  ));
}
