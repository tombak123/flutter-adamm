import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(MyWidget());

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Controller",
      theme: ThemeData(primaryColor: Colors.blue),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class ClockWidget extends StatefulWidget {
  @override
  _ClockWidgetState createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<ClockWidget> {
  String _currentTime = '';

  @override
  void initState() {
    super.initState();
    // Mettre à jour l'heure actuelle toutes les secondes
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = _getCurrentTime();
      });
    });
  }

  String _getCurrentTime() {
    var now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _currentTime,
      style: TextStyle(color: Colors.white),
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  final _nomController = TextEditingController();
  String _nom = '';
  int _nbrlettres = 0;
  int _nbrconsonnes = 0;
  int _countA = 0;
  int _countE = 0;
  int _countI = 0;
  int _countO = 0;
  int _countU = 0;
  int _countY = 0;

  @override
  void dispose() {
    _nomController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    setState(() {
      _nom = _nomController.text;
      _nbrlettres = _nom.length;
      _countA = _nom.replaceAll(RegExp('[^aA]'), '').length;
      _countE = _nom.replaceAll(RegExp('[^eE]'), '').length;
      _countI = _nom.replaceAll(RegExp('[^iI]'), '').length;
      _countO = _nom.replaceAll(RegExp('[^oO]'), '').length;
      _countU = _nom.replaceAll(RegExp('[^uU]'), '').length;
      _countY = _nom.replaceAll(RegExp('[^yY]'), '').length;
      _nbrconsonnes = _nom.length - (_countA + _countE + _countI + _countO + _countU + _countY);
    });
  }

  void _vider() {
    setState(() {
      _nom = "";
      _nomController.clear();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ClockWidget(),
        title: Padding(
          padding: EdgeInsets.only(top: 30.0), // Décalage vers le bas du texte
          child: Text(
            "ANALYSE VOYELLE",
            style: TextStyle(color: Colors.white), // Couleur du texte en blanc
          ),
        ),
        actions: [
          SizedBox(width: 10),
          Icon(Icons.wifi, color: Colors.white),
          SizedBox(width: 10),
          Transform.rotate(
            angle: 90 * 3.141592653 / 180, // Rotation de 90 degrés
            child: Icon(Icons.battery_full, color: Colors.white), // Icône de charge de batterie en blanc
          ),
          SizedBox(width: 10),
        ],
        backgroundColor: Colors.lightBlue,
        centerTitle: true, // Titre centré
        iconTheme: IconThemeData(color: Colors.white), // Couleur des icônes
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: _nomController,
              decoration: InputDecoration(
                  hintText: "Entrez un mot",
                  suffixIcon: IconButton(
                      onPressed: () {
                        _nomController.clear();
                      },
                      icon: Icon(Icons.clear)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12))),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _onSubmit,
                  child: Text("Analyser"),
                ),
              ],
            ),
            SizedBox(height: 20),
            _nom.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildResultContainer(' a  :  $_countA occurences',
                          const Color.fromARGB(255, 255, 60, 0)),
                      _buildResultContainer(' e  :  $_countE occurences',
                          const Color.fromARGB(255, 255, 0, 55)),
                      _buildResultContainer(' i  :  $_countI occurences',
                          Colors.orange),
                      _buildResultContainer(' o  :  $_countO occurences',
                          const Color.fromARGB(255, 111, 255, 0)),
                      _buildResultContainer(' u  :  $_countU occurences',
                          Color.fromARGB(255, 3, 151, 62)),
                      _buildResultContainer(' y  :  $_countY occurences',
                          Color.fromARGB(255, 0, 238, 255)),
                      _buildResultContainer(' Consonnes :  $_nbrconsonnes occurences',
                          Colors.black),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget _buildResultContainer(String text, Color color) {
    return Container(
      width: 300,
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
