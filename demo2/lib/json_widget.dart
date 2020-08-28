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
    //_run();
  }

  Future<void> _run() async {
    var lastFrameTime = DateTime.now().millisecondsSinceEpoch;

    //Stopwatch watch = Stopwatch();
    var parses = 0;
    //watch.start();
    //var lastTime = watch.elapsedMilliseconds;
    while (true) {
      parseJson();
      parses ++ ;
      // Allow UI to update every 1s & set counter
      final time = DateTime.now().millisecondsSinceEpoch;
      if ((time - lastFrameTime) > 1000) {
        print(parses);
//        setState(() {
//          parsesPerSecond = parses;
//        });
        parses = 0;
        lastFrameTime = time;
        await Future.microtask(() {});
      }
//      var elapsedMilliseconds = watch.elapsedMilliseconds;
//      if ((elapsedMilliseconds - lastTime)  > 1000) {
//        print(parses);
//        setState(() {
//          parsesPerSecond = parses;
//        });
//        parses = 0;
//        lastTime = elapsedMilliseconds;
//        await Future.microtask(() {});
//      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.red,height: 220,);
//    return Text(
//      parsesPerSecond.toString(),
//      style: TextStyle(
//          color: Colors.black,
//          fontSize: 40.0
//      ),
//    );
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