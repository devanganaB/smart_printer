import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PrintedFilesPage extends StatefulWidget {
  @override
  _PrintedFilesPageState createState() => _PrintedFilesPageState();
}

class _PrintedFilesPageState extends State<PrintedFilesPage> {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Printed Files'),
      ),
      body: _buildPrintedFilesList(),
    );
  }

  Widget _buildPrintedFilesList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('PrintedFiles')
          .where('userEmail', isEqualTo: user!.email)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.data!.docs.isEmpty) {
          return Text('No printed files available.');
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            String fileName = data['fileName'];
            String userEmail = data['userEmail'];
            int copies = data['copies'];

            return ListTile(
              title: Text('File Name: $fileName'),
              subtitle: Text('User Email: $userEmail, Copies: $copies'),
            );
          }).toList(),
        );
      },
    );
  }
}




