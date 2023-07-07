// import 'package:flutter/material.dart';

// class ViewProfile extends StatefulWidget {
//   const ViewProfile({super.key});
//   @override
//   State<ViewProfile> createState() => _ViewProfile();
// }

// class _ViewProfile extends State<ViewProfile> {
//   String? selectedBranch;
//   String? selectedYear;

//   List<PrintHistoryItem> printHistory = [
//     PrintHistoryItem(
//       date: 'June 10, 2023',
//       time: '10:30 AM',
//       documentName: 'Document 1',
//       pageCount: 5,
//     ),
//     PrintHistoryItem(
//       date: 'June 9, 2023',
//       time: '2:45 PM',
//       documentName: 'Document 2',
//       pageCount: 10,
//     ),
//   ];

//   bool accountSettingsExpanded = false;
//   bool paymentInfoExpanded = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.menu),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         title: Text('Profile'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.edit),
//             onPressed: () {
//               print('Edit profile');
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.save),
//             onPressed: () {
//               print('Save button pressed');
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.cancel),
//             onPressed: () {
//               print('Cancel button pressed');
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Center(
//               child: CircleAvatar(
//                 radius: 60.0,
//                 child: Icon(
//                   Icons.person,
//                   size: 60.0,
//                   color: Theme.of(context).textTheme.bodyText1!.color,
//                 ),
//               ),
//             ),
//             SizedBox(height: 16.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Username',
//                   style: TextStyle(
//                     fontSize: 24.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.edit),
//                   onPressed: () {
//                     print('Edit username');
//                   },
//                 ),
//               ],
//             ),
//             SizedBox(height: 16.0),
//             Divider(),
//             SizedBox(height: 16.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Contact Information',
//                   style: TextStyle(
//                     fontSize: 20.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.edit),
//                   onPressed: () {
//                     print('Edit contact information');
//                   },
//                 ),
//               ],
//             ),
//             SizedBox(height: 8.0),
//             Card(
//               child: ListTile(
//                 leading: Icon(
//                   Icons.phone,
//                   color: Theme.of(context).textTheme.bodyText1!.color,
//                 ),
//                 title: Text('+91 123 456 789'),
//               ),
//             ),
//             Card(
//               child: ListTile(
//                 leading: Icon(
//                   Icons.email,
//                   color: Theme.of(context).textTheme.bodyText1!.color,
//                 ),
//                 title: Text('username@gmail.com'),
//               ),
//             ),
//             SizedBox(height: 16.0),
//             Divider(),
//             SizedBox(height: 16.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Educational Details',
//                   style: TextStyle(
//                     fontSize: 20.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.edit),
//                   onPressed: () {
//                     print('Edit educational details');
//                   },
//                 ),
//               ],
//             ),
//             SizedBox(height: 8.0),
//             Card(
//               child: ListTile(
//                 leading: Icon(
//                   Icons.library_add,
//                   color: Theme.of(context).textTheme.bodyText1!.color,
//                 ),
//                 title: Text('LIBRARY CARD NO'),
//               ),
//             ),
//             SizedBox(height: 8.0),
//             Card(
//               child: ListTile(
//                 leading: Icon(
//                   Icons.business,
//                   color: Theme.of(context).textTheme.bodyText1!.color,
//                 ),
//                 title: Text(
//                   'Branch',
//                   style: TextStyle(
//                     fontSize: 16.0,
//                   ),
//                 ),
//                 trailing: DropdownButton<String>(
//                   value: selectedBranch,
//                   items: <String>['CMPN', 'IT', 'AIDS', 'EXTC']
//                       .map((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value),
//                     );
//                   }).toList(),
//                   onChanged: (String? newValue) {
//                     setState(() {
//                       selectedBranch = newValue;
//                     });
//                   },
//                 ),
//               ),
//             ),
//             SizedBox(height: 16.0),
//             Card(
//               child: ListTile(
//                 leading: Icon(
//                   Icons.calendar_today,
//                   color: Theme.of(context).textTheme.bodyText1!.color,
//                 ),
//                 title: Text(
//                   'Year',
//                   style: TextStyle(
//                     fontSize: 16.0,
//                   ),
//                 ),
//                 trailing: DropdownButton<String>(
//                   value: selectedYear,
//                   items: <String>['F.E.', 'S.E.', 'T.E.', 'B.E.', 'Other']
//                       .map((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value),
//                     );
//                   }).toList(),
//                   onChanged: (String? newValue) {
//                     setState(() {
//                       selectedYear = newValue;
//                     });
//                   },
//                 ),
//               ),
//             ),
//             SizedBox(height: 8.0),
//             Card(
//               child: ListTile(
//                 leading: Icon(
//                   Icons.add,
//                   color: Theme.of(context).textTheme.bodyText1!.color,
//                 ),
//                 title: Text('Division'),
//               ),
//             ),
//             SizedBox(height: 16.0),
//             Divider(),
//             SizedBox(height: 16.0),
//             ExpansionPanelList(
//               elevation: 1,
//               expandedHeaderPadding: EdgeInsets.all(0),
//               expansionCallback: (int index, bool isExpanded) {
//                 setState(() {
//                   if (index == 0)
//                     accountSettingsExpanded = !isExpanded;
//                   else if (index == 1) paymentInfoExpanded = !isExpanded;
//                 });
//               },
//               children: [
//                 ExpansionPanel(
//                   headerBuilder: (BuildContext context, bool isExpanded) {
//                     return ListTile(
//                       title: Text(
//                         'Account Settings',
//                         style: TextStyle(
//                           fontSize: 20.0,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     );
//                   },
//                   body: Column(
//                     children: [
//                       ListTile(
//                         title: Text('Change Password'),
//                         onTap: () {
//                           print('Change password');
//                         },
//                       ),
//                       ListTile(
//                         title: Text('Update Email Preferences'),
//                         onTap: () {
//                           print('Update email preferences');
//                         },
//                       ),
//                       ListTile(
//                         title: Text('Link Account to Other Platforms'),
//                         onTap: () {
//                           print('Link account to other platforms');
//                         },
//                       ),
//                     ],
//                   ),
//                   isExpanded: accountSettingsExpanded,
//                 ),
//                 ExpansionPanel(
//                   headerBuilder: (BuildContext context, bool isExpanded) {
//                     return ListTile(
//                       title: Text(
//                         'Payment Information',
//                         style: TextStyle(
//                           fontSize: 20.0,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     );
//                   },
//                   body: Column(
//                     children: [
//                       ListTile(
//                         title: Text('View Payment Information'),
//                         onTap: () {
//                           print('View payment information');
//                         },
//                       ),
//                       ListTile(
//                         title: Text('Add UPI'),
//                         onTap: () {
//                           print('Add UPI');
//                         },
//                       ),
//                       ListTile(
//                         title: Text('Update UPI Details'),
//                         onTap: () {
//                           print('Update UPI details');
//                         },
//                       ),
//                     ],
//                   ),
//                   isExpanded: paymentInfoExpanded,
//                 ),
//               ],
//             ),
//             SizedBox(height: 16.0),
//             Divider(),
//             SizedBox(height: 16.0),
//             Text(
//               'Print History',
//               style: TextStyle(
//                 fontSize: 20.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 8.0),
//             ListView.builder(
//               shrinkWrap: true,
//               physics: NeverScrollableScrollPhysics(),
//               itemCount: printHistory.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return ListTile(
//                   title: Text(printHistory[index].documentName),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('Date: ${printHistory[index].date}'),
//                       Text('Time: ${printHistory[index].time}'),
//                       Text(
//                         'Pages: ${printHistory[index].pageCount}',
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class PrintHistoryItem {
//   final String date;
//   final String time;
//   final String documentName;
//   final int pageCount;

//   PrintHistoryItem({
//     required this.date,
//     required this.time,
//     required this.documentName,
//     required this.pageCount,
//   });
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// UserProfile class code...
class UserProfile {
  final String name;
  final String email;
  final String branch;
  final String division;
  final String libraryCardNo;

  UserProfile(
      {
    required this.name,
    required this.email,
    required this.branch,
    required this.division,
    required this.libraryCardNo,
  }
  );
}

// Payment class code...
class Payment {
  final String date;
  final double amount;

  Payment({required this.date, required this.amount});
}

// PrintRecord class code...
class PrintRecord {
  final String date;
  final String documentName;
  final int pageCount;

  PrintRecord({required this.date, required this.documentName, required this.pageCount});
}

class ViewProfile extends StatefulWidget {
  const ViewProfile({Key? key}) : super(key: key);

  @override
  _ViewProfileState createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  late User _currentUser;
  late UserProfile _userProfile;
  List<Payment> _paymentHistory = [];
  List<PrintRecord> _printHistory = [];

  @override
  void initState() {
    super.initState();
    _currentUser = FirebaseAuth.instance.currentUser!;
    _loadUserProfile();
    _loadPaymentHistory();
    _loadPrintHistory();
  }

  void _loadUserProfile() async {
    final userDetailsSnapshot = await FirebaseFirestore.instance
        .collection('Users Details')
        .doc(_currentUser.email)
        .get();

    final userProfileData = userDetailsSnapshot.data();
    if (userProfileData != null) {
      setState(() {
        _userProfile = UserProfile(
          name: userProfileData['NAME'],
          email: _currentUser.email!,
          branch: userProfileData['BRANCH'],
          division: userProfileData['DIVISION'],
          libraryCardNo: userProfileData['LIB-CARD_NO'],
        );
      });
    }
  }

  void _loadPrintHistory() async {
    final printHistorySnapshot = await FirebaseFirestore.instance
        .collection('Print History')
        .doc(_currentUser.email)
        .collection('Prints')
        .get();

    final printHistoryData = printHistorySnapshot.docs;

    setState(() {
      _printHistory = printHistoryData.map((printSnapshot) {
        final printData = printSnapshot.data();
        return PrintRecord(
          date: printData['date'],
          documentName: printData['document_name'],
          pageCount: printData['page_count'],
        );
      }).toList();
    });
  }

  void _loadPaymentHistory() async {
    final paymentHistorySnapshot = await FirebaseFirestore.instance
        .collection('Payment History')
        .doc(_currentUser.email)
        .collection('Payments')
        .get();

    final paymentHistoryData = paymentHistorySnapshot.docs;

    setState(() {
      _paymentHistory = paymentHistoryData.map((paymentSnapshot) {
        final paymentData = paymentSnapshot.data();
        return Payment(
          date: paymentData['date'],
          amount: paymentData['amount'].toDouble(),
        );
      }).toList();
    });
  }

  void _editProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditProfile(userProfile: _userProfile)),
    ).then((value) {
      _loadUserProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _editProfile,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFB7C9F3), // Lighter shade of blue
              Color(0xFFF5FDF9), // Lighter shade of green
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: _userProfile == null
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 60.0,
                  child: Icon(
                    Icons.person,
                    size: 60.0,
                    color: Theme.of(context).textTheme.bodyText1!.color,
                  ),
                ),
              ),
              const Divider(),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Contact Information',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _buildCard(
                icon: Icons.person,
                title: 'Name',
                subtitle: _userProfile.name,
                editAction: _editProfile,
              ),
              const SizedBox(height: 8),
              _buildCard(
                icon: Icons.email,
                title: 'Email',
                subtitle: _userProfile.email,
                editAction: _editProfile,
              ),
              const Divider(),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Educational Details',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _buildCard(
                icon: Icons.work,
                title: 'Branch',
                subtitle: _userProfile.branch,
                editAction: _editProfile,
              ),
              const SizedBox(height: 8),
              _buildCard(
                icon: Icons.people,
                title: 'Division',
                subtitle: _userProfile.division,
                editAction: _editProfile,
              ),
              const SizedBox(height: 8),
              _buildCard(
                icon: Icons.library_books,
                title: 'Library Card No',
                subtitle: _userProfile.libraryCardNo,
                editAction: _editProfile,
              ),
              const Divider(),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Print History',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              _buildPrintHistory(),
              const Divider(),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Payment Information',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              _buildPaymentHistory(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback editAction,
  }) {
    return Card(
      color: Colors.white.withOpacity(0.9),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 2.0,
      child: ListTile(
        leading: Icon(icon),
        title: Text(
          title,
          style: const TextStyle(fontSize: 20),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.left,
        ),
        trailing: IconButton(
          icon: const Icon(Icons.settings),
          onPressed: editAction,
        ),
      ),
    );
  }

  Widget _buildPaymentHistory() {
    if (_paymentHistory.isEmpty) {
      return Text('No payment history available.');
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _paymentHistory.length,
      itemBuilder: (context, index) {
        final payment = _paymentHistory[index];
        final paymentDate = payment.date;
        final paymentAmount = payment.amount;

        return ListTile(
          leading: Icon(Icons.payment),
          title: Text('Payment Date: $paymentDate'),
          subtitle: Text('Payment Amount: $paymentAmount'),
        );
      },
    );
  }

  Widget _buildPrintHistory() {
    if (_printHistory.isEmpty) {
      return Text('No print history available.');
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _printHistory.length,
      itemBuilder: (context, index) {
        final printRecord = _printHistory[index];
        final printDate = printRecord.date;
        final printDocumentName = printRecord.documentName;
        final printPageCount = printRecord.pageCount;

        return ListTile(
          leading: Icon(Icons.print),
          title: Text('Date: $printDate'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Document Name: $printDocumentName'),
              Text('Page Count: $printPageCount'),
            ],
          ),
        );
      },
    );
  }
}


class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const MyButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Theme.of(context).primaryColor,
      child: Text(text),
    );
  }
}

class EditProfile extends StatefulWidget {
  final UserProfile userProfile;

  const EditProfile({Key? key, required this.userProfile}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late TextEditingController _nameController;
  late TextEditingController _branchController;
  late TextEditingController _divisionController;
  late TextEditingController _libraryCardNoController;

  List<String> _branchOptions = [
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
  ];

  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.userProfile.name);
    _branchController = TextEditingController(text: widget.userProfile.branch);
    _divisionController = TextEditingController(text: widget.userProfile.division);
    _libraryCardNoController = TextEditingController(text: widget.userProfile.libraryCardNo);
  }

  void _submitChanges() async {
    if (_isFormValid) {
      final updatedProfile = UserProfile(
        name: _nameController.text,
        email: widget.userProfile.email,
        branch: _branchController.text,
        division: _divisionController.text,
        libraryCardNo: _libraryCardNoController.text,
      );

      final updatedDetails = {
        'NAME': updatedProfile.name,
        'BRANCH': updatedProfile.branch,
        'DIVISION': updatedProfile.division,
        'LIB-CARD_NO': updatedProfile.libraryCardNo,
      };

      // Save updated profile to Firestore or any other data source

      await FirebaseFirestore.instance
          .collection('Users Details')
          .doc(widget.userProfile.email)
          .update(updatedDetails);

      Navigator.pop(context, updatedProfile);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _branchController.dispose();
    _divisionController.dispose();
    _libraryCardNoController.dispose();
    super.dispose();
  }

  void _cancelEditing() {
    Navigator.pop(context);
  }

  void _validateForm() {
    setState(() {
      _isFormValid = _nameController.text.isNotEmpty &&
          _branchController.text.isNotEmpty &&
          _divisionController.text.isNotEmpty &&
          _libraryCardNoController.text.length == 8; // Check if length is exactly 8 digits
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFB7C9F3), // Lighter shade of blue
              Color(0xFFC9F0E4),
            ],
          ),
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                onChanged: (value) => _validateForm(),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () async {
                  final selectedBranch = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Select Branch'),
                        content: SingleChildScrollView(
                          child: Column(
                            children: _branchOptions.map((branch) {
                              return ListTile(
                                title: Text(branch),
                                onTap: () {
                                  Navigator.pop(context, branch);
                                },
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  );

                  if (selectedBranch != null) {
                    setState(() {
                      _branchController.text = selectedBranch;
                      _validateForm();
                    });
                  }
                },
                child: TextFormField(
                  controller: _branchController,
                  decoration: InputDecoration(
                    labelText: 'Branch',
                    suffixIcon: Icon(Icons.arrow_drop_down),
                  ),
                  enabled: false,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _divisionController,
                decoration: InputDecoration(labelText: 'Division'),
                onChanged: (value) => _validateForm(),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _libraryCardNoController,
                decoration: InputDecoration(labelText: 'Library Card No'),
                onChanged: (value) => _validateForm(),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: _submitChanges,
                    child: const Text('Save'),
                    style: ElevatedButton.styleFrom(
                      primary: _isFormValid ? null : Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: _cancelEditing,
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ViewProfile(),
  ));
}
