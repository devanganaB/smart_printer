import 'package:flutter/material.dart';
import 'package:smart_printer/Screens/AboutUs.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const UserAccountsDrawerHeader(
          accountName: Text('alexadamie'),
          accountEmail: Text('xyz@hotmail.com'),
          currentAccountPicture: CircleAvatar(
              backgroundColor: Color.fromARGB(0, 0, 0, 0),
              child: ClipOval(
                child: Icon(
                  Icons.account_circle,
                  size: 78,
                  color: Colors.pink,
                ),
              )),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg.png'),
                  fit: BoxFit.cover)),
        ),
        ListTile(
          leading: const Icon(Icons.account_circle_outlined),
          title: const Text('View Profile'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.accessibility),
          title: const Text('About Us'),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const AboutUs()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.call),
          title: const Text('Contact Us'),
          onTap: () {},
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
          onTap: () {},
        )
      ],
    ));
  }
}
