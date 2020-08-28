import 'dart:convert';

import 'package:flutter/material.dart';

class JsonTest extends StatefulWidget {
  @override
  _JsonTestState createState() => _JsonTestState();
}

class _JsonTestState extends State<JsonTest> {
  var parsesPerSecond = 0;

  @override
  void initState() {
    super.initState();
    // Start test on next tick
    Future.microtask(_run);
  }

  Future<void> _run() async {
    var lastFrame = DateTime.now();

    Stopwatch watch = Stopwatch();


    var parses = 0;
    watch.start();
    while (true) {
      parseJson();

      // Allow UI to update every 1s & set counter
      //final time = DateTime.now().subtract(Duration(seconds: 1));
      var elapsedMilliseconds = watch.elapsedMilliseconds;
      if (elapsedMilliseconds > 1000) {
        setState(() {
          parsesPerSecond = parses;
        });
        parses = 0;
        watch.stop();
        //await Future.microtask(() {});
        watch.start();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      parsesPerSecond.toString(),
      style: TextStyle(
          color: Colors.black,
          fontSize: 40.0
      ),
    );
  }
}

//const jsonToParse = "";

//void parseJson() {
//  // Implement parsing here
//}


const jsonToParse = """{
  "debug": "on",
  "window": {
    "title": "Sample Konfabulator Widget",
    "name": "main_window",
    "width": 500,
    "height": 500
  }
}""";

void parseJson() {
  json.decode(jsonToParse);
}