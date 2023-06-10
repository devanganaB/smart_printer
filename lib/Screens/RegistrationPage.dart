import 'package:flutter/material.dart';
import 'package:smart_printer/Screens/LoginPage.dart';
import 'package:smart_printer/Screens/SideMenu.dart';
import 'package:smart_printer/Screens/dummy.dart';

class RegisterPage extends StatefulWidget {
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
                      buildTextField('Name', nameController, Icons.person),
                      buildTextField('Email', emailController, Icons.email),
                      buildTextField(
                          'Contact Number', contactController, Icons.phone),
                      buildTextField(
                          'Branch', branchController, Icons.business),
                      buildTextField(
                          'Division', divisionController, Icons.location_city),
                      buildTextField('Library Card No', libraryCardController,
                          Icons.credit_card),
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
                            String name = nameController.text;
                            String email = emailController.text;
                            String contact = contactController.text;
                            String branch = branchController.text;
                            String division = divisionController.text;
                            String libraryCardNo = libraryCardController.text;
                            String password = passwordController.text;

                            registerUser(
                              name,
                              email,
                              contact,
                              branch,
                              division,
                              libraryCardNo,
                              password,
                            );
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
                            return LoginPage();
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

  Widget buildTextField(
      String label, TextEditingController controller, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: 264,
      height: 56,
      child: TextFormField(
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
          prefixIcon:const Icon(Icons.lock),
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
    String email,
    String contact,
    String branch,
    String division,
    String libraryCardNo,
    String password,
  ) {
    // Perform registration logic here

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
      return;
    }

    // Perform further validation and registration process

    // Placeholder code
  }
}

void main() {
  runApp(MaterialApp(
    home: RegisterPage(),
  ));
}
