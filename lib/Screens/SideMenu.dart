import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: [
        UserAccountsDrawerHeader(
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
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg.png'),
                  fit: BoxFit.cover)),
        ),
        ListTile(
          leading: Icon(Icons.account_circle_outlined),
          title: Text('View Profile'),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.accessibility),
          title: Text('About Us'),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.call),
          title: Text('Contact Us'),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.help),
          title: Text('Help'),
          onTap: () {},
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text('Logout'),
          onTap: () {},
        )
      ],
    ));
  }
}
