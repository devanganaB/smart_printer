import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_printer/Screens/SideMenu.dart';
import 'package:smart_printer/Screens/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Printer',
      theme: ThemeData(
        // app's theme configuration
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final String user = FirebaseAuth.instance.currentUser!.email!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContactUs(defaultEmail: user)),
              );
            },
            child: Text('Contact Us'),
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              padding: EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
          ),
        ),
      ),
    );
  }
}

class ContactUs extends StatelessWidget {
  //Added controllers.
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController messageController;

  // Initialized  controllers.
  ContactUs({Key? key, required String defaultEmail})
      : nameController = TextEditingController(),
        phoneController = TextEditingController(),
        messageController = TextEditingController(),
        super(key: key) {
    emailController.text = defaultEmail;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFA0B5EB), Color(0xFFC9F0E4)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),

          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 60.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: CircleAvatar(
                    child: Icon(Icons.arrow_back, size: 30.0, color: Colors.blue),
                    backgroundColor:Colors.white.withOpacity(0.5),
                    radius: 30.0,
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  'Contact Us',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 30.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  'Team',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  // color: Colors.white,
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(height: 20),
                    Text(
                      "We value your input! Get in touch with us and we'll be happy to respond as soon as possible.",
                      style: TextStyle(fontSize: 18, color: Colors.blue,fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      autofocus: false,
                      enabled: false, // Adding this line to disable editing
                      decoration: InputDecoration(
                        hintText: "Enter your email",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: "Enter your name",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                    ),

                    SizedBox(height:20),
                    TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: "Enter your phone number",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                    ),

                    SizedBox(height: 20),
                    TextFormField(
                      controller: messageController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: "Enter your message",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                    ),
                    SizedBox(height: 40),
                    Container(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () {
                          submitForm(context);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                        child: Text(
                          "Submit",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  // Retrieve values.

  void submitForm(BuildContext context) async {
    String email = emailController.text;
    String name = nameController.text;
    String phone = phoneController.text;
    String message = messageController.text;

    // Added to Firestore document.
    if (email.isNotEmpty && name.isNotEmpty && phone.isNotEmpty && message.isNotEmpty) {
      await FirebaseFirestore.instance.collection('contacts').add({
        'email': email,
        'name': name,
        'message': message,
        'phone': phone,
        'timestamp': DateTime.now(),
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Success"),
            content: Text("Form submitted successfully!"),
            actions: <Widget>[
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      // Clear  fields.

      // emailController.clear();
      nameController.clear();
      messageController.clear();
      phoneController.clear();

    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Please fill in all the fields."),
            actions: <Widget>[
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
