import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smart_printer/Screens/SideMenu.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<File> _selectedFiles = [];
  List<String?> _filePaths = [];
  List<int> _numberOfCopies = [];
  String sides = 'one-side';
  String orien = 'portrait';
  String? _status;

  Future<void> _pickFiles() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();
      List<String?> filePaths = result.paths.toList();

      List<int> numberOfCopies = List<int>.filled(files.length, 1);
      setState(() {
        _selectedFiles = files;
        _filePaths = filePaths;
        _numberOfCopies = numberOfCopies;
      });
    }
  }

  Future<void> _transferFiles() async {
    if (_selectedFiles.isEmpty) {
      setState(() {
        _status = 'No files selected';
      });
      return;
    }

    try {
      // Get the PC's IP address and the folder path
      String pcIpAddress = '172.24.240.1'; // Replace with the PC's IP address

      // Prepare the URL for file transfer
      Uri url = Uri.parse('http://$pcIpAddress:3000/upload');

      for (int i = 0; i < _selectedFiles.length; i++) {
        for (int j = 0; j < _numberOfCopies[i]; j++) {
          String originalFileName = path.basename(_filePaths[i]!);

          // Generate a unique name (e.g., by appending a timestamp)
          String uniqueFileName =
              '${DateTime.now().millisecondsSinceEpoch}_$originalFileName';

          // Get the directory for temporary storage
          Directory tempDir = await getTemporaryDirectory();
          String tempPath = path.join(tempDir.path, uniqueFileName);

          // Copy or move the file to the temporary location with the unique name
          await _selectedFiles[i].copy(tempPath);

          // Create a multipart request
          var request = http.MultipartRequest('POST', url);

          // Attach the selected file to the request
          request.files.add(await http.MultipartFile.fromPath('pdf', tempPath));
          request.files.add(await http.MultipartFile.fromPath('txt', tempPath));

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
      }
    } catch (e) {
      setState(() {
        _status = 'Error: $e';
      });
    }
    _emptyList();
  }

  void _deleteFile(int index) async {
    await _selectedFiles.remove(_selectedFiles[index]);
    await _filePaths.remove(_filePaths[index]);
    await _numberOfCopies.remove(_numberOfCopies[index]);
  }

  void _emptyList() {
    _selectedFiles.clear();
    _filePaths.clear();
    _numberOfCopies.clear();
  }

  Widget build(BuildContext context) {
    print("selectedFiles : $_selectedFiles");
    print("_filePaths : $_filePaths");
    print("_numberOfCopies : $_numberOfCopies");
    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        title: const Text(
          'Home Page',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromRGBO(167, 136, 232, 100),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFA0B5EB), Color(0xFFC9F0E4)],
          ),
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              Text(
                'Smart Printer',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Open Sans',
                ),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white.withOpacity(0.5),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Select PDF Files',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 80,
                      width: 300,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 26, 96, 217)),
                        onPressed: _pickFiles,
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
                    if (_selectedFiles.isNotEmpty)
                      Column(
                        children: List.generate(_selectedFiles.length, (index) {
                          String fileName =
                              _selectedFiles[index].path.split('/').last;

                          return Column(
                            children: [
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Icon(Icons.picture_as_pdf),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      '${fileName}',
                                      style: const TextStyle(fontSize: 16),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if (_numberOfCopies[index] > 1) {
                                          _numberOfCopies[index]--;
                                        }
                                      });
                                    },
                                    icon: const Icon(Icons.remove),
                                  ),
                                  Text(
                                    '${_numberOfCopies[index]}',
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _numberOfCopies[index]++;
                                      });
                                    },
                                    icon: const Icon(Icons.add),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _deleteFile(index);
                                        });
                                      },
                                      icon: Icon(Icons.delete))
                                ],
                              ),
                              const SizedBox(height: 16),
                            ],
                          );
                        }),
                      ),
                    if (_status != null) Text(_status!),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white.withOpacity(0.5),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Print Settings',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Print Sides:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 10),
                        DropdownButton<String>(
                          value: sides,
                          onChanged: (String? newValue) {
                            setState(() {
                              sides = newValue!;
                            });
                          },
                          items: <String>[
                            'one-side',
                            'two-side-long-edge',
                            'two-side-short-edge',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Orientation:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 10),
                        DropdownButton<String>(
                          value: orien,
                          onChanged: (String? newValue) {
                            setState(() {
                              orien = newValue!;
                            });
                          },
                          items: <String>['portrait', 'landscape']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _transferFiles,
                child: const Text('Print'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
