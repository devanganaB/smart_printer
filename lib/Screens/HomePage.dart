import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smart_printer/Screens/SideMenu.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int numberOfCopies = 1;
  String sides = 'one-side';
  String orien = 'potrait';

  File? _selectedFile;
  String? _status;
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
    }
  }

  Future<void> _transferFile() async {
    if (_selectedFile == null) {
      setState(() {
        _status = 'No file selected';
      });
      return;
    }

    try {
      // Get the PC's IP address and the folder path
      String pcIpAddress = '192.168.0.168'; // Replace with the PC's IP address
      String folderPath =
          '/Users/dipanshughime/projects/pdfprinter/'; // Replace with the folder path on the PC

      // Prepare the URL for file transfer
      Uri url = Uri.parse('http://$pcIpAddress:3000/upload');

      for (int i = 0; i < numberOfCopies; i++) {
        print(numberOfCopies);

        String originalFileName = path.basename(_selectedFile!.path);

        // Generate a unique name (e.g., by appending a timestamp)
        String uniqueFileName =
            '${DateTime.now().millisecondsSinceEpoch}_$originalFileName';

        // Get the directory for temporary storage
        Directory tempDir = await getTemporaryDirectory();
        String tempPath = path.join(tempDir.path, uniqueFileName);

        // Copy or move the file to the temporary location with the unique name
        await _selectedFile!.copy(tempPath);

        // Create a multipart request
        var request = http.MultipartRequest('POST', url);

        // Attach the selected file to the request
        request.files.add(await http.MultipartFile.fromPath('pdf', tempPath));

        // Send the request
        var response = await request.send();

        // Check the response status
        if (response.statusCode == 200) {
          setState(() {
            _status = 'File transferred successfully';
          });
        } else {
          setState(() {
            _status = 'Failed to transfer file';
          });
        }
      }
    } catch (e) {
      setState(() {
        _status = 'Error: $e';
      });
    }
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: SideMenu(),
        appBar: AppBar(
          title: Text(
            'Home Page',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color.fromRGBO(167, 136, 232, 100),
        ),
        body: Container(
          decoration: const BoxDecoration(
              // gradient: LinearGradient(colors:[Color(0xFFEDAEF9),Color(0xFF81B1FA)])
              gradient: LinearGradient(
                  colors: [Color(0xFFA0B5EB), Color(0xFFC9F0E4)])),
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 390,
                  height: 600,
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 200,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 60,
                                  width: 190,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      " Used Pages : ",
                                      style: TextStyle(
                                          height: 1.5,
                                          wordSpacing: 1,
                                          fontFamily: 'Times New Roman',
                                          fontSize: 18),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(1),
                                  height: 35,
                                  width: 80,
                                  child: TextField(
                                    style: TextStyle(
                                      fontFamily: 'Times New Roman',
                                    ),
                                    textAlign: TextAlign.center,
                                    cursorHeight: 15,
                                    decoration: InputDecoration(
                                        fillColor: Colors.amber,
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)))),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 80,
                            width: 300,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromARGB(255, 26, 96, 217)),
                              onPressed: _pickFile,
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.white,
                                    child: Image.asset(
                                        "assets/images/cloud-upload.gif",
                                        height: 28),
                                  ),
                                  const Text("   UPLOAD DOCUMENT",
                                      style: TextStyle(
                                          wordSpacing: 1,
                                          fontFamily: 'Times New Roman',
                                          fontSize: 18))
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 100,
                          ),
                          ElevatedButton(
                            onPressed: _transferFile,
                            child: Text('Transfer File'),
                          ),
                          SizedBox(height: 16),
                          if (_selectedFile != null)
                            Text('Selected File: ${_selectedFile!.path}'),
                          if (_status != null) Text(_status!),
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(1, 1, 1, 0),
                                height: 380,
                                width: 300,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25)),
                                    color: Color.fromRGBO(167, 136, 232, 100)),
                                child: Column(children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 60,
                                        width: 190,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Number of Copies: ",
                                            style: TextStyle(
                                                height: 1.5,
                                                wordSpacing: 1,
                                                fontFamily: 'Times New Roman',
                                                fontSize: 18),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(1),
                                        height: 35,
                                        width: 80,
                                        child: TextField(
                                          style: TextStyle(
                                            fontFamily: 'Times New Roman',
                                          ),
                                          textAlign: TextAlign.center,
                                          cursorHeight: 15,
                                          onChanged: (value) {
                                            setState(() {
                                              numberOfCopies =
                                                  int.tryParse(value) ?? 1;
                                            });
                                          },
                                          decoration: InputDecoration(
                                            fillColor: Colors.amber,
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 60,
                                        width: 190,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            " Total Pages : ",
                                            style: TextStyle(
                                                height: 1.5,
                                                wordSpacing: 1,
                                                fontFamily: 'Times New Roman',
                                                fontSize: 18),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(1),
                                        height: 35,
                                        width: 80,
                                        child: TextField(
                                          style: TextStyle(
                                            fontFamily: 'Times New Roman',
                                          ),
                                          textAlign: TextAlign.center,
                                          cursorHeight: 15,
                                          decoration: InputDecoration(
                                              fillColor: Colors.amber,
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              20)))),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 60,
                                        width: 100,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "one-side",
                                            style: TextStyle(
                                                height: 1.5,
                                                wordSpacing: 1,
                                                fontFamily: 'Times New Roman',
                                                fontSize: 18),
                                          ),
                                        ),
                                      ),
                                      Radio(
                                          value: "one-side",
                                          groupValue: sides,
                                          onChanged: (value) {
                                            setState(() {
                                              sides = value.toString();
                                            });
                                          }),
                                      Container(
                                        height: 60,
                                        width: 100,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "both-side",
                                            style: TextStyle(
                                                height: 1.5,
                                                wordSpacing: 1,
                                                fontFamily: 'Times New Roman',
                                                fontSize: 18),
                                          ),
                                        ),
                                      ),
                                      Radio(
                                          value: "single-sided",
                                          groupValue: sides,
                                          onChanged: (value) {
                                            setState(() {
                                              sides = value.toString();
                                            });
                                          })
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 60,
                                        width: 100,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "potrait",
                                            style: TextStyle(
                                                height: 1.5,
                                                wordSpacing: 1,
                                                fontFamily: 'Times New Roman',
                                                fontSize: 18),
                                          ),
                                        ),
                                      ),
                                      Radio(
                                          value: "potrait",
                                          groupValue: orien,
                                          onChanged: (value) {
                                            setState(() {
                                              orien = value.toString();
                                            });
                                          }),
                                      Container(
                                        height: 60,
                                        width: 100,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "landscape",
                                            style: TextStyle(
                                                height: 1.5,
                                                wordSpacing: 1,
                                                fontFamily: 'Times New Roman',
                                                fontSize: 18),
                                          ),
                                        ),
                                      ),
                                      Radio(
                                          value: "landscape",
                                          groupValue: orien,
                                          onChanged: (value) {
                                            setState(() {
                                              orien = value.toString();
                                            });
                                          })
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 60,
                                        width: 190,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            " available : ",
                                            style: TextStyle(
                                                height: 1.5,
                                                wordSpacing: 1,
                                                fontFamily: 'Times New Roman',
                                                fontSize: 18),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(1),
                                        height: 35,
                                        width: 80,
                                        child: TextField(
                                          style: TextStyle(
                                            fontFamily: 'Times New Roman',
                                          ),
                                          textAlign: TextAlign.center,
                                          cursorHeight: 15,
                                          decoration: InputDecoration(
                                              fillColor: Colors.amber,
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              20)))),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 60,
                                        width: 190,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            " limit : ",
                                            style: TextStyle(
                                                height: 1.5,
                                                wordSpacing: 1,
                                                fontFamily: 'Times New Roman',
                                                fontSize: 18),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(1),
                                        height: 35,
                                        width: 80,
                                        child: TextField(
                                          style: TextStyle(
                                            fontFamily: 'Times New Roman',
                                          ),
                                          textAlign: TextAlign.center,
                                          cursorHeight: 15,
                                          decoration: InputDecoration(
                                              fillColor: Colors.amber,
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              20)))),
                                        ),
                                      ),
                                    ],
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ]),
                  ),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  SizedBox(height: 100),
                  Container(
                    height: 40,
                    width: 120,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 26, 96, 217)),
                      onPressed: () {},
                      child: Row(
                        children: [
                          const Text("PROCEED",
                              style: TextStyle(
                                  wordSpacing: 1,
                                  fontFamily: 'Times New Roman',
                                  fontSize: 18))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 100),
                  Container(
                    height: 40,
                    width: 120,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 26, 96, 217)),
                      onPressed: () {},
                      child: Row(
                        children: [
                          const Text("CANCEL",
                              style: TextStyle(
                                  wordSpacing: 1,
                                  fontFamily: 'Times New Roman',
                                  fontSize: 18))
                        ],
                      ),
                    ),
                  ),
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
