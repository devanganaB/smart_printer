import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_printer/Screens/AboutUs.dart';
import 'package:smart_printer/Screens/LoginPage.dart';
import 'package:smart_printer/Screens/ViewProfile.dart';
import 'package:smart_printer/Screens/ContactUs.dart';


class SideMenu extends StatelessWidget {
  SideMenu({super.key});
  final user = FirebaseAuth.instance.currentUser!.email;

  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('Users Details');

    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: [
        StreamBuilder(
        stream: users.doc(user).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return UserAccountsDrawerHeader(
            accountName: Text(data['NAME']),
            // accountEmail: Text(user!),
            accountEmail: Text(user != null ? user! : 'No Email'),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Color.fromARGB(0, 0, 0, 0),
              child: ClipOval(
                child: Icon(
                  Icons.account_circle,
                  size: 78,
                  color: Colors.pink,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg.png'),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),

        // UserAccountsDrawerHeader(
        //         accountName: Text('Raghav'),
        //         // accountEmail: Text(user!),
        //         accountEmail: Text(user != null ? user! : 'No Email'),
        //         currentAccountPicture: const CircleAvatar(
        //             backgroundColor: Color.fromARGB(0, 0, 0, 0),
        //             child: ClipOval(
        //               child: Icon(
        //                 Icons.account_circle,
        //                 size: 78,
        //                 color: Colors.pink,
        //               ),
        //             )),
        //         decoration: const BoxDecoration(
        //             image: DecorationImage(
        //                 image: AssetImage('assets/images/bg.png'),
        //                 fit: BoxFit.cover)),
        //       ),
            
        ListTile(
          leading: const Icon(Icons.account_circle_outlined),
          title: const Text('View Profile'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ViewProfile()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.accessibility),
          title: const Text('About Us'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AboutUs()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.call),
          title: const Text('Contact Us'),
          onTap: () {
            Navigator.push(
              context,
              // MaterialPageRoute(builder: (context) => ContactUs()),
              MaterialPageRoute(builder: (context) => ContactUs(defaultEmail: user ?? '')),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.help),
          title: const Text('Help'),
          onTap: () {},
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Logout'),
          onTap: () {
            FirebaseAuth.instance.signOut();
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const LoginPage();
            }));
          },
        )
      ],
    ));
  }
}
