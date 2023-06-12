import 'package:flutter/material.dart';
import 'package:smart_printer/Screens/SideMenu.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  String sides = 'one-side';
  String orien = 'potrait';
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
                            onPressed: () {},
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
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                    decoration: InputDecoration(
                                        fillColor: Colors.amber,
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)))),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)))),
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
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)))),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)))),
                                  ),
                                ),
                              ],
                            ),
                          ]),
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
    );
  }
}
