import 'package:flutter/material.dart';

class ViewProfile extends StatefulWidget {
  const ViewProfile({super.key});
  @override
  State<ViewProfile> createState() => _ViewProfile();
}

class _ViewProfile extends State<ViewProfile> {
  String? selectedBranch;
  String? selectedYear;

  List<PrintHistoryItem> printHistory = [
    PrintHistoryItem(
      date: 'June 10, 2023',
      time: '10:30 AM',
      documentName: 'Document 1',
      pageCount: 5,
    ),
    PrintHistoryItem(
      date: 'June 9, 2023',
      time: '2:45 PM',
      documentName: 'Document 2',
      pageCount: 10,
    ),
  ];

  bool accountSettingsExpanded = false;
  bool paymentInfoExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              print('Edit profile');
            },
          ),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              print('Save button pressed');
            },
          ),
          IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {
              print('Cancel button pressed');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Username',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    print('Edit username');
                  },
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Divider(),
            SizedBox(height: 16.0),
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
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    print('Edit contact information');
                  },
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Card(
              child: ListTile(
                leading: Icon(
                  Icons.phone,
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                title: Text('+91 123 456 789'),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(
                  Icons.email,
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                title: Text('username@gmail.com'),
              ),
            ),
            SizedBox(height: 16.0),
            Divider(),
            SizedBox(height: 16.0),
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
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    print('Edit educational details');
                  },
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Card(
              child: ListTile(
                leading: Icon(
                  Icons.library_add,
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                title: Text('LIBRARY CARD NO'),
              ),
            ),
            SizedBox(height: 8.0),
            Card(
              child: ListTile(
                leading: Icon(
                  Icons.business,
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                title: Text(
                  'Branch',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                trailing: DropdownButton<String>(
                  value: selectedBranch,
                  items: <String>['CMPN', 'IT', 'AIDS', 'EXTC']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedBranch = newValue;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Card(
              child: ListTile(
                leading: Icon(
                  Icons.calendar_today,
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                title: Text(
                  'Year',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                trailing: DropdownButton<String>(
                  value: selectedYear,
                  items: <String>['F.E.', 'S.E.', 'T.E.', 'B.E.', 'Other']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedYear = newValue;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Card(
              child: ListTile(
                leading: Icon(
                  Icons.add,
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                title: Text('Division'),
              ),
            ),
            SizedBox(height: 16.0),
            Divider(),
            SizedBox(height: 16.0),
            ExpansionPanelList(
              elevation: 1,
              expandedHeaderPadding: EdgeInsets.all(0),
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  if (index == 0)
                    accountSettingsExpanded = !isExpanded;
                  else if (index == 1) paymentInfoExpanded = !isExpanded;
                });
              },
              children: [
                ExpansionPanel(
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      title: Text(
                        'Account Settings',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                  body: Column(
                    children: [
                      ListTile(
                        title: Text('Change Password'),
                        onTap: () {
                          print('Change password');
                        },
                      ),
                      ListTile(
                        title: Text('Update Email Preferences'),
                        onTap: () {
                          print('Update email preferences');
                        },
                      ),
                      ListTile(
                        title: Text('Link Account to Other Platforms'),
                        onTap: () {
                          print('Link account to other platforms');
                        },
                      ),
                    ],
                  ),
                  isExpanded: accountSettingsExpanded,
                ),
                ExpansionPanel(
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      title: Text(
                        'Payment Information',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                  body: Column(
                    children: [
                      ListTile(
                        title: Text('View Payment Information'),
                        onTap: () {
                          print('View payment information');
                        },
                      ),
                      ListTile(
                        title: Text('Add UPI'),
                        onTap: () {
                          print('Add UPI');
                        },
                      ),
                      ListTile(
                        title: Text('Update UPI Details'),
                        onTap: () {
                          print('Update UPI details');
                        },
                      ),
                    ],
                  ),
                  isExpanded: paymentInfoExpanded,
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Divider(),
            SizedBox(height: 16.0),
            Text(
              'Print History',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: printHistory.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(printHistory[index].documentName),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Date: ${printHistory[index].date}'),
                      Text('Time: ${printHistory[index].time}'),
                      Text(
                        'Pages: ${printHistory[index].pageCount}',
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PrintHistoryItem {
  final String date;
  final String time;
  final String documentName;
  final int pageCount;

  PrintHistoryItem({
    required this.date,
    required this.time,
    required this.documentName,
    required this.pageCount,
  });
}
