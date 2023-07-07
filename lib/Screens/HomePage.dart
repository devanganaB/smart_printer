import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:smart_printer/Screens/SideMenu.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;
import 'package:smart_printer/Screens/ViewProfile.dart';

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
  num _numberOfPages = 0;

  Future<void> _pickFiles() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();
      List<String?> filePaths = result.paths.toList();

      List<int> numberOfCopies = List<int>.filled(files.length, 1);
      String pcIpAddress = '172.24.240.1';
      Uri url = Uri.parse('http://$pcIpAddress:3000/pages');
      setState(() {
        _selectedFiles = files;
        _filePaths = filePaths;
        _numberOfCopies = numberOfCopies;
      });
      for (int i = 0; i < _selectedFiles.length; i++) {
        try {
          int numberOfPages = await countPages(_selectedFiles[i]);
          print('Number of pages in the file: $numberOfPages');
        } catch (e) {
          print('Error: $e');
        }
      }

      // print('for loop starting');
      // try {
      //   for (int i = 0; i < _selectedFiles.length; i++) {
      //     var request = http.MultipartRequest('POST', url);
      //     request.files
      //         .add(await http.MultipartFile.fromPath('pdf', _filePaths[i]!));
      //     var response = await request.send();
      //   }
      // } catch (e) {
      //   print("error");
      // }

      // print('for loop ending');
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
      String pcIpAddress = '172.26.192.1'; // Replace with the PC's IP address

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

          // Send the request
          var streamedResponse = await request.send();
          var response = await http.Response.fromStream(streamedResponse);
          // Check the response status
          if (response.statusCode == 200) {
            setState(() {
              _status = 'File transferred successfully';
              final data = json.decode(response.body);
              _numberOfPages += data['pages'];

              print("this is pages");
              print(_numberOfPages);
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

  Future<int> countPages(File file) async {
    if (await file.exists()) {
      List<String> list = file.readAsLinesSync();

      int lineCount = list.length;
      ;
      // await file.openRead().transform(utf8.decoder).forEach((line) {
      //   lineCount++;
      // });

      // Assuming an average of 50 lines per page, you can estimate the number of pages.
      int pages = (lineCount / 50).ceil();
      return pages;
    } else {
      throw FileSystemException('File not found');
    }
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
              Text(
                'number of pages used: $_numberOfPages',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              Container(
                width: MediaQuery.sizeOf(context).width * 0.8,
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
                      height: MediaQuery.sizeOf(context).height * 0.1,
                      width: MediaQuery.sizeOf(context).width * 0.7,
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
                                    fontSize: 15))
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
